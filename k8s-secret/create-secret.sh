# create docker config secret
kubectl create secret generic -n devops-tools nexus-s3t-co-docker-config --from-file=.dockerconfigjson=config.json --type=kubernetes.io/dockerconfigjson

# create nexus credentials as secret which we will use from setting.xml on build
kubectl create secret generic -n devops-tools nexus-s3t-co-secret --from-literal=username=xxxxxx --from-literal=password=xxxxxx

# create nexus mvn-url as secret which we will use from setting.xml on build
kubectl create secret generic -n devops-tools jenkins-skaffold-agent-env --from-literal=group=docker-g.nexus.s3t.co --from-literal=release=docker-r.nexus.s3t.co --from-literal=snapshoot=docker-s.nexus.s3t.co

