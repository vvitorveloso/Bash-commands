#!/bin/bash
#
# Script to test help functionality of all scripts

echo "Testing help functionality for all scripts..."
echo "==========================================="

# Get all script files from parent directory (excluding README, backup, etc.)
for script in $(ls -1 ../ | grep -v "README.md" | grep -v "all_scripts.txt" | grep -v "backup_before_rename" | grep -v "test"); do
    # Skip the test directory and the test script itself
    if [[ "$script" == "test" ]]; then
        continue
    fi

    # Check if the file is actually a shell or Python script before testing
    file_output=$(file "../$script" 2>/dev/null)
    if [[ "$file_output" != *"shell script"* && "$file_output" != *"Python script"* ]]; then
        # Skip non-script files like mutter-winit
        continue
    fi

    echo -n "Testing $script ... "

    # Check if it's a Python script by file extension or shebang
    if [[ "$script" == *.py ]] || head -n 1 "../$script" 2>/dev/null | grep -q "python"; then
        # For Python scripts, try with Python - check for any help-related output
        if python3 "../$script" -h 2>/dev/null | grep -q -i "Usage\|help\|Options\|Description\|Purpose\|show_help\|command\|Examples\|Arguments\|Configuration"; then
            echo "OK (Python)"
        elif python3 "../$script" --help 2>/dev/null | grep -q -i "Usage\|help\|Options\|Description\|Purpose\|show_help\|command\|Examples\|Arguments\|Configuration"; then
            echo "OK (Python --help)"
        else
            echo "FAILED"
        fi
    else
        # For shell scripts, try with bash - check for any help-related output
        if bash -c "../$script -h" 2>/dev/null | grep -q -i "Usage\|help\|Options\|Description\|Purpose\|show_help\|command\|Examples\|Arguments\|Configuration"; then
            echo "OK (bash)"
        elif bash -c "../$script --help" 2>/dev/null | grep -q -i "Usage\|help\|Options\|Description\|Purpose\|show_help\|command\|Examples\|Arguments\|Configuration"; then
            echo "OK (bash --help)"
        else
            echo "FAILED"
        fi
    fi
done

echo
echo "Testing complete!"