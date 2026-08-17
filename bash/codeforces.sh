# Codeforces Workflow
# ===================

CF_DIR="$HOME/Codeforces"

cf() {
    case "$1" in

        # Create a new contest directory
        init)
            if [[ -z "$2" ]]; then
                echo "Usage: cf init <contest>"
                return 1
            fi

            local contest="$2"
            local contest_dir="$CF_DIR/$contest"

            mkdir -p -- "$contest_dir" || return 1
            cd -- "$contest_dir" || return 1

            echo "Contest: $contest"
            echo "Directory: $contest_dir"
            ;;


        # Create a new problem
        new)
            if [[ -z "$2" ]]; then
                echo "Usage: cf new <problem>"
                return 1
            fi

            if [[ ! -d "$CF_DIR" ]]; then
                echo "Codeforces directory not found."
                echo "Run: cf init <contest>"
                return 1
            fi

            local problem="$2"
            local file="${problem}.cpp"

            if [[ -f "$file" ]]; then
                echo "Problem already exists: $file"
                nvim "$file"
                return
            fi

            cat > "$file" <<'EOF'
#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    return 0;
}
EOF

            echo "Created: $(pwd)/$file"

            nvim "$file"
            ;;


        # Compile and run a problem
        run)
            local file="${2:-main.cpp}"

            if [[ ! -f "$file" ]]; then
                echo "File not found: $file"
                return 1
            fi

            if [[ "${file##*.}" != "cpp" ]]; then
                echo "Not a C++ source file: $file"
                return 1
            fi

            local executable="${file%.cpp}"

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
            echo "  cf init <contest>   Create a contest directory"
            echo "  cf new <problem>    Create and open a problem"
            echo "  cf run [file]       Compile and run a problem"
            return 1
            ;;
    esac
}
