#!/bin/bash
#
# Script to check script structure for proper help implementation
# This checks if help functions are placed before privilege checks

echo "Checking script structure for proper help implementation..."
echo "========================================================="

# Get all shell script files
for script in $(ls -1 | grep -v "README.md" | grep -v "all_scripts.txt" | grep -v "backup_before_rename" | grep -v "test_all_help.sh" | grep -v "check_script_structure.sh"); do
    echo -n "Checking $script ... "
    
    # Check if it's a shell script
    if [[ "$script" != *.py ]]; then
        # For shell scripts, check if help check comes before privilege checks
        help_line=$(grep -n -m 1 "\[.*-h\|.*--help" "$script" | cut -d: -f1)
        privilege_line=$(grep -n -m 1 "EUID\|sudo.*-v\|sudo.*||\[\[.*EUID" "$script" | cut -d: -f1)
        
        if [ -n "$help_line" ] && [ -n "$privilege_line" ] && [ "$help_line" -lt "$privilege_line" ]; then
            echo "OK (help before privileges)"
        elif [ -n "$help_line" ] && [ -z "$privilege_line" ]; then
            echo "OK (help present, no privilege checks)"
        elif [ -z "$help_line" ]; then
            echo "MISSING HELP"
        else
            echo "PROBLEM (privileges before help)"
        fi
    else
        # For Python scripts, just check if help exists
        if grep -q "help\|Usage\|Options" "$script"; then
            echo "OK (Python script)"
        else
            echo "CHECK PYTHON"
        fi
    fi
done

echo
echo "Structure check complete!"