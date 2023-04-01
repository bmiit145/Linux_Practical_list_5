#!/bin/bash

# validate command line arguments
if [ $# -ne 2 ]; then
  echo "Usage: $0 <branch name> <customer id>"
  exit
fi

# assign command line arguments to variables
branch_name="$1"
customer_id="$2"

# get branch ID from branch name
branch_id=$(awk -v branch_name="$branch_name" 'tolower($2) == tolower(branch_name) {print $1}' BRANCH.txt)

# get customer details from customer ID
customer_details=$(awk -v customer_id="$customer_id" '$1 == customer_id {print $0}' CUSTOMERS.txt)

# if customer details not found
if [ -z "$customer_details" ]; then
  echo "Customer Record not found"
  exit
fi

# print customer details
echo "Customer details:"
echo "C_ID | Customer Name | Cust City"
echo "$customer_details"

# get deposit details for customer in branch
deposit_details=$(awk -v customer_id="$customer_id" -v branch_id="$branch_id" '$2 == customer_id && $3 == branch_id {print $4}' DEPOSIT.txt)

# if deposit details not found, print error message and exit
if [ -z "$deposit_details" ]; then
  echo "Deposit not found"
  exit 1
fi

# calculate total deposited amount # it has standard input std
total_deposited_amount=$(awk '{s+=$1} END {print s}' <<< "$deposit_details")

# print deposit details and total deposited amount
echo "Deposit details for customer in branch:"
echo "Amount deposited: $deposit_details"
echo "Total deposited amount: $total_deposited_amount"


# run as pr_3.sh kamrej 101