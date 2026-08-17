# Codeforces Workflow
# ===================

CF_DIR="$HOME/Codeforces"


# Validate contest ID
cf_valid_contest_id() {
    [[ "$1" =~ ^[0-9]+$ ]]
}


# Check whether the current directory is a Codeforces contest directory
cf_require_contest() {
    if [[ "$PWD" =~ ^"$CF_DIR"/([0-9]+)$ ]]; then
        return 0
    fi

    echo "Error: Not inside a Codeforces contest directory."
    echo "Run: cf init <contest_id>"
    return 1
}


cf() {
    case "$1" in

        # Initialize a contest
        init)
            if [[ -z "$2" ]]; then
                echo "Usage: cf init <contest_id>"
                return 1
            fi

            if ! cf_valid_contest_id "$2"; then
                echo "Error: Contest ID must be a number."
                return 1
            fi

            local contest_id="$2"
            local contest_dir="$CF_DIR/$contest_id"

            mkdir -p -- "$contest_dir" || return 1
            cd -- "$contest_dir" || return 1

            echo "Contest initialized: $contest_id"
            echo "Directory: $contest_dir"
            ;;


        # Create a new problem
        new)
            if [[ -z "$2" ]]; then
                echo "Usage: cf new <problem_index> [-t|--tests]"
                return 1
            fi

            cf_require_contest || return 1

            local problem_index="$2"
            local file="${problem_index}.cpp"
            local tests=false

            case "$3" in
                -t|--tests)
                    tests=true
                    ;;
                "")
                    ;;
                *)
                    echo "Usage: cf new <problem_index> [-t|--tests]"
                    return 1
                    ;;
            esac

            if [[ -f "$file" ]]; then
                echo "Problem already exists: $file"
                nvim "$file"
                return
            fi

            if [[ "$tests" == true ]]; then
                cat > "$file" <<'EOF'
#include <bits/stdc++.h>
using namespace std;

void solve() {

}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int t;
    cin >> t;

    while (t--) {
        solve();
    }

    return 0;
}
EOF
            else
                cat > "$file" <<'EOF'
#include <bits/stdc++.h>
using namespace std;

void solve() {

}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    solve();

    return 0;
}
EOF
            fi

            echo "Created: $(pwd)/$file"

            nvim "$file"
            ;;


        # Compile and run a problem
        run)
            if [[ -z "$2" ]]; then
                echo "Usage: cf run <problem_index>"
                return 1
            fi

            cf_require_contest || return 1

            local problem_index="$2"
            local file="${problem_index}.cpp"
            local executable="$problem_index"

            if [[ ! -f "$file" ]]; then
                echo "Problem not found: $file"
                return 1
            fi

            g++ \
                -std=c++20 \
                -O2 \
                -Wall \
                -Wextra \
                -Wshadow \
                "$file" \
                -o "$executable" || return 1

            echo "Running: $file"
            echo

            "./$executable"
            ;;


        # Show help
        *)
            echo "Usage:"
            echo "  cf init <contest_id>             Initialize a contest"
            echo "  cf new <problem_index>           Create a single-test problem"
            echo "  cf new <problem_index> -t        Create a multi-test problem"
            echo "  cf new <problem_index> --tests   Create a multi-test problem"
            echo "  cf run <problem_index>           Compile and run a problem"
            return 1
            ;;
    esac
}
