echo 'DEPLOY TO REGISTRY'
docker login --username $DOCKERHUB_USERNAME --password $DOCKERHUB_PASSWORD
docker build -f Dockerfile -t $SERVICE .
docker tag $SERVICE $DOCKERHUB_USERNAME/$SERVICE:$VERSION
docker push $DOCKERHUB_USERNAME/$SERVICE:$VERSION
echo 'DEPLOY TO KUBERNETES'
curl 'https://raw.githubusercontent.com/joaollr86/egeo_architecture/main/'$SERVICE'_deploy.yml' > deploy_base.yml
cat deploy_base.yml
apt-get install gettext-base
envsubst < deploy_base.yml > deploy.yml
cat deploy.yml