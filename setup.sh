#!/bin/bash

echo "Starting setup..."

sudo apt update -y
sudo apt install -y docker.io curl

sudo systemctl start docker
sudo systemctl enable docker

echo "Running container..."

sudo docker run -d -p 8000:80 --restart always tiangolo/uvicorn-gunicorn-fastapi:python3.9

echo "Creating health check..."

cat <<EOT > /home/ubuntu/health_check.sh
#!/bin/bash

STATUS=$(curl -o /dev/null -s -w "%{http_code}" http://localhost:8000)

if [ "$STATUS" != "200" ]; then
    docker restart $(docker ps -q)
fi
EOT

chmod +x /home/ubuntu/health_check.sh

(crontab -l 2>/dev/null; echo "* * * * * /home/ubuntu/health_check.sh") | crontab -

echo "Setup complete!"