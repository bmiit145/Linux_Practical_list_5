#!/bin/bash

# Accept employee name as input
echo "Enter employee name: "
read employee_name

# Find employee details from Employee file
employee_details=$(grep -i ":$employee_name:" Employee.txt)

# Extract employee ID from employee details
employee_id=$(echo $employee_details | cut -d ':' -f 1)

# Find all tasks assigned to employee from Task_allocation file
tasks=$(grep -i ":$employee_id:" Task_allocation.txt)

# Print employee details
echo "Employee details:"
echo "ID : Name : Salary : Department"
echo  $employee_details

# Print assigned task details and status
echo "Assigned task(s):"
while read -r task; do
    task_details=$(echo $task | cut -d ':' -f 2,4)
    proj_id=$(echo $task | cut -d':' -f 4)
    proj_name=$(grep -i "$proj_id" project.txt | cut -d ':' -f 2)
    task_status=$(echo $task | cut -d ':' -f 5)
    echo "=> Task: $task_details | Project: $proj_name |Status: $task_status"
done <<< "$tasks"
