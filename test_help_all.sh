#!/bin/bash
#
# Test all scripts with help option

echo "Testing all scripts with -h option:"
echo "==================================="

total=0
success=0
failed=0

while IFS= read -r script; do
    if [[ -n "$script" && "$script" != "test_help_all.sh" ]]; then
        ((total++))
        echo -n "Testing $script with -h ... "

        # Determine if it's a Python script or shell script
        if [[ "$script" == *.py ]]; then
            # For Python scripts, try with Python
            if python3 "$script" -h >/dev/null 2>&1; then
                echo "OK"
                ((success++))
            else
                echo "FAILED"
                ((failed++))
            fi
        else
            # For shell scripts, try with bash
            if bash -c "./$script -h" >/dev/null 2>&1; then
                echo "OK"
                ((success++))
            else
                echo "FAILED"
                ((failed++))
            fi
        fi
    fi
done < script_list.txt

echo
echo "Testing complete!"
echo "Total scripts tested: $total"
echo "Successful: $success"
echo "Failed: $failed"
echo

if [ $failed -gt 0 ]; then
    echo "Testing --help for remaining scripts:"
    echo "====================================="

    while IFS= read -r script; do
        if [[ -n "$script" && "$script" != "test_help_all.sh" ]]; then
            # Only test scripts that are not Python extensions
            if [[ "$script" != BackSpaceGnome47.py && "$script" != BackSpaceGnome47.py.1 ]]; then
                echo -n "Testing $script with --help ... "

                if [[ "$script" == *.py ]]; then
                    if python3 "$script" --help >/dev/null 2>&1; then
                        echo "OK"
                    else
                        echo "FAILED"
                    fi
                else
                    if bash -c "./$script --help" >/dev/null 2>&1; then
                        echo "OK"
                    else
                        echo "FAILED"
                    fi
                fi
            fi
        fi
    done < script_list.txt
fi