#! /bin/bash
#!/bin/bash

# Read employee id from user
read -p "Enter employee id: " emp_id

# Extract employee data based on given employee id
employee_data=$(grep "^$emp_id:" Employee.txt)
emp_name=$(echo "$employee_data" | cut -d ':' -f 2)
department=$(echo "$employee_data" | cut -d ':' -f 4)

# Employee id wise report
echo ""
echo ""
echo " Employee id wise report "
echo "Employee Name: $emp_name"
echo "Department: $department"
echo "task_id task_description emp_name project_name"
grep ":$emp_id:" Task.txt | while read line
do
    task_id=$(echo "$line" | cut -d ':' -f 1)
    task_description=$(echo "$line" | cut -d ':' -f 2)
    project_id=$(echo "$line" | cut -d ':' -f 4)
    project_name=$(grep "^$project_id:" Project.txt | cut -d ':' -f 2)
    echo "$task_id $task_description $emp_name $project_name"
done


# Employee wise project details
echo ""
echo ""
echo " Employee wise project details "
echo "Employee Name: $emp_name"
echo "Department: $department"
echo "Project id project name"
grep ":$emp_id:" Task.txt | cut -d ':' -f 4 | sort -u | while read project_id
do
    project_name=$(grep "^$project_id:" Project.txt | cut -d ':' -f 2)
    echo "$project_id $project_name"
done
