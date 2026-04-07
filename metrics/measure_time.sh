#!/bin/bash

echo "Starting automated deployment..."

start=$(date +%s)

cd ../terraform
terraform apply -auto-approve

end=$(date +%s)

time_taken=$((end - start))

echo "----------------------------------"
echo "Deployment Time: $time_taken seconds"
echo "----------------------------------"