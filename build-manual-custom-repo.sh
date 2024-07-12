export REGISTRY_URL="docker-r.nexus.s3t.co"
export REGISTRY_USERNAME="xxx"
export REGISTRY_PASSWORD="xxx"

docker system prune

docker login -u $REGISTRY_USERNAME -p $REGISTRY_PASSWORD $REGISTRY_URL

docker build -t smart-web-bot-agent:latest .

docker tag smart-web-bot-agent:latest $REGISTRY_URL/smart-web-bot-agent:latest

docker push $REGISTRY_URL/smart-web-bot-agent:latest
