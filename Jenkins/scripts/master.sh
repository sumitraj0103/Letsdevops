#!/bin/bash

echo "This is master.sh"
# Call child
echo "Jenkins username in master.sh: $username"
./child.sh

