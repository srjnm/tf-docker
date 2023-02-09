cd docker-files
docker build -t srjnm/managed-nginx:v2 -f managed-node.Dockerfile .
docker push srjnm/managed-nginx:v2
cd ..