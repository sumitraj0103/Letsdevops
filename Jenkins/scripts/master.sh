#!/bin/bash

echo "This is master.sh"
# Call child
echo "Jenkins username in master.sh: $username"
echo "Jenkins username in master.sh: $password" 
./child.sh

