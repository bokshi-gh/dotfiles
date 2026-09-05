# Codeforces Toolkit
# ==================

CF_DIR="$HOME/Codeforces"


# ─────────────────────────────────────────────
# Validation
# ─────────────────────────────────────────────

cf_valid_contest_id() {
    [[ "$1" =~ ^[0-9]+$ ]]
}

cf_valid_problem_index() {
    [[ "$1" =~ ^[A-Za-z]+$ ]]
}


# ─────────────────────────────────────────────
# Helpers
# ─────────────────────────────────────────────

# Check whether we are inside a Codeforces contest directory
cf_require_contest() {
    if [[ "$PWD" =~ ^"$CF_DIR"/[0-9]+$ ]]; then
        return 0
    fi

    echo "Error: Not inside a Codeforces contest directory."
    echo "Run: cf init <contest_id>"
    return 1
}


# Copy a file to the system clipboard
cf_copy_to_clipboard() {
    local file="$1"

    if command -v pbcopy &>/dev/null; then
        pbcopy < "$file"

    elif command -v wl-copy &>/dev/null; then
        wl-copy < "$file"

    elif command -v xclip &>/dev/null; then
        xclip -selection clipboard < "$file"

    elif command -v xsel &>/dev/null; then
        xsel --clipboard --input < "$file"

    else
        echo "Error: No clipboard utility found."
        echo
        echo "Install one of:"
        echo "  wl-clipboard  (Wayland)"
        echo "  xclip         (X11)"
        echo "  xsel          (X11)"
        return 1
    fi

    return 0
}


# ─────────────────────────────────────────────
# Main Codeforces command
# ─────────────────────────────────────────────

cf() {
    case "$1" in

        # ─────────────────────────────────────
        # Initialize a contest
        # ─────────────────────────────────────
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

            echo "✓ Contest initialized: $contest_id"
            echo "  Directory: $contest_dir"
            ;;


        # ─────────────────────────────────────
        # Create a new solution
        # ─────────────────────────────────────
        new)
            if [[ -z "$2" ]]; then
                echo "Usage: cf new <problem_index>"
                echo "       cf new <problem_index> [-t | --tests]"
                return 1
            fi

            cf_require_contest || return 1

            local problem_index="$2"
            local file="${problem_index}.cpp"
            local tests=false

            if ! cf_valid_problem_index "$problem_index"; then
                echo "Error: Problem index must contain only letters."
                return 1
            fi

            case "$3" in
                -t|--tests)
                    tests=true
                    ;;

                "")
                    ;;

                *)
                    echo "Usage: cf new <problem_index>"
                    echo "       cf new <problem_index> [-t | --tests]"
                    return 1
                    ;;
            esac

            # Existing solution
            if [[ -f "$file" ]]; then
                echo "Solution already exists: $file"
                nvim "$file"
                return
            fi

            # Multi-test template
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

            # Single-test template
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

            echo "✓ Created: $(pwd)/$file"

            nvim "$file"
            ;;


        # ─────────────────────────────────────
        # Compile and run a solution
        # ─────────────────────────────────────
        run)
            if [[ -z "$2" ]]; then
                echo "Usage: cf run <problem_index>"
                return 1
            fi

            cf_require_contest || return 1

            local problem_index="$2"
            local file="${problem_index}.cpp"
            local executable="$problem_index"

            if ! cf_valid_problem_index "$problem_index"; then
                echo "Error: Problem index must contain only letters."
                return 1
            fi

            if [[ ! -f "$file" ]]; then
                echo "Solution not found: $file"
                return 1
            fi

            echo "Compiling: $file"
            echo

            g++ \
                -std=c++20 \
                -O2 \
                -Wall \
                -Wextra \
                -Wshadow \
                "$file" \
                -o "$executable" || {
                    echo
                    echo "✗ Compilation failed."
                    return 1
                }

            echo
            echo "Running: $file"
            echo "────────────────────────────────────"
            echo

            "./$executable"
            local status=$?

            echo
            echo "────────────────────────────────────"

            # Remove compiled executable
            rm -f -- "$executable"

            if [[ $status -eq 0 ]]; then
                echo "✓ Finished successfully."
            else
                echo "✗ Program exited with status: $status"
            fi

            return "$status"
            ;;


        # ─────────────────────────────────────
        # Copy solution to clipboard
        # ─────────────────────────────────────
        copy)
            if [[ -z "$2" ]]; then
                echo "Usage: cf copy <problem_index>"
                return 1
            fi

            cf_require_contest || return 1

            local problem_index="$2"
            local file="${problem_index}.cpp"

            if ! cf_valid_problem_index "$problem_index"; then
                echo "Error: Problem index must contain only letters."
                return 1
            fi

            if [[ ! -f "$file" ]]; then
                echo "Solution not found: $file"
                return 1
            fi

            if cf_copy_to_clipboard "$file"; then
                echo "✓ Copied $file to clipboard."
                echo "  Ready to paste into Codeforces."
            else
                return 1
            fi
            ;;


        # ─────────────────────────────────────
        # Show current contest
        # ─────────────────────────────────────
        current)
            cf_require_contest || return 1

            local contest_id
            contest_id="${PWD##*/}"

            echo "Contest: $contest_id"
            echo "Directory: $PWD"
            ;;


        # ─────────────────────────────────────
        # List solutions
        # ─────────────────────────────────────
        list)
            cf_require_contest || return 1

            echo "Contest: ${PWD##*/}"
            echo
            echo "Solutions:"
            echo "────────────────────────────────────"

            local found=false

            for file in *.cpp; do
                [[ -e "$file" ]] || continue

                echo "  $file"
                found=true
            done

            if [[ "$found" == false ]]; then
                echo "  No solutions yet."
            fi

            echo "────────────────────────────────────"
            ;;


        # ─────────────────────────────────────
        # Open an existing solution
        # ─────────────────────────────────────
        edit)
            if [[ -z "$2" ]]; then
                echo "Usage: cf edit <problem_index>"
                return 1
            fi

            cf_require_contest || return 1

            local problem_index="$2"
            local file="${problem_index}.cpp"

            if ! cf_valid_problem_index "$problem_index"; then
                echo "Error: Problem index must contain only letters."
                return 1
            fi

            if [[ ! -f "$file" ]]; then
                echo "Solution not found: $file"
                echo "Use: cf new $problem_index"
                return 1
            fi

            nvim "$file"
            ;;


        # ─────────────────────────────────────
        # Compile only
        # ─────────────────────────────────────
        build)
            if [[ -z "$2" ]]; then
                echo "Usage: cf build <problem_index>"
                return 1
            fi

            cf_require_contest || return 1

            local problem_index="$2"
            local file="${problem_index}.cpp"
            local executable="$problem_index"

            if ! cf_valid_problem_index "$problem_index"; then
                echo "Error: Problem index must contain only letters."
                return 1
            fi

            if [[ ! -f "$file" ]]; then
                echo "Solution not found: $file"
                return 1
            fi

            echo "Compiling: $file"

            g++ \
                -std=c++20 \
                -O2 \
                -Wall \
                -Wextra \
                -Wshadow \
                "$file" \
                -o "$executable" || {
                    echo
                    echo "✗ Compilation failed."
                    return 1
                }

            echo "✓ Build successful: $executable"
            ;;


        # ─────────────────────────────────────
        # Clean compiled executables
        # ─────────────────────────────────────
        clean)
            cf_require_contest || return 1

            local removed=false

            for file in *.cpp; do
                [[ -e "$file" ]] || continue

                local executable="${file%.cpp}"

                if [[ -f "$executable" && -x "$executable" ]]; then
                    rm -f -- "$executable"
                    echo "✓ Removed: $executable"
                    removed=true
                fi
            done

            if [[ "$removed" == false ]]; then
                echo "Nothing to clean."
            fi
            ;;


        # ─────────────────────────────────────
        # Help
        # ─────────────────────────────────────
        help|"")
            echo
            echo "Codeforces Toolkit"
            echo "==================="
            echo
            echo "Contest:"
            echo "  cf init <contest_id>                   Initialize a contest"
            echo "  cf current                             Show current contest"
            echo "  cf list                                List solution files"
            echo
            echo "Solutions:"
            echo "  cf new <problem_index>                 Create single-test solution"
            echo "  cf new <problem_index> [-t|--tests]    Create multi-test solution"
            echo "  cf edit <problem_index>                Open existing solution"
            echo
            echo "Compile / Run:"
            echo "  cf build <problem_index>               Compile only"
            echo "  cf run <problem_index>                 Compile and run"
            echo "  cf clean                               Remove compiled binaries"
            echo
            echo "Clipboard:"
            echo "  cf copy <problem_index>                Copy solution to clipboard"
            echo
            ;;


        # ─────────────────────────────────────
        # Unknown command
        # ─────────────────────────────────────
        *)
            echo "Unknown command: $1"
            echo
            echo "Run 'cf help' for available commands."
            return 1
            ;;
    esac
}
