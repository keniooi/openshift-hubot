# Build hubot docker image
HUBOT_SLACK_TOKEN value is required in Dockerfile. if you use template, you can
set it during deployment.
 
```
docker build -t nodejs/bot4you .
```

# Import docker to openshift 
Login as your user of openshift and create new project nodejs.
And login to docker registry without check (I need to --skip-check option to login)
You can check docker registry url with "oc registry info" on my environment.
It is "docker-registry.default.svc:5000". You need to set this value to kubernetes.yaml.

```
oc login
oc new-project nodejs
oc registry login --skip-check
docker login -u `oc whoami` -p `oc whoami -t` `oc registry info`
oc registry info
docker tag nodejs/bot4you:latest `oc registry info`/`oc project -q`/bot4you:latest
docker push `oc registry info`/`oc project -q`/bot4you:latest
oc get is
```

# Create template
Create template with following command. Please change image tag of DeploymentConfig
in template.yaml

```
oc create -f template.yaml
```


# Apply yaml to openshift
Following step is to create deployments, services and routes without template.
Update kubernetes.yaml with "oc registry info" output. You can use vi to edit it.
And apply kubernetes.yaml

```
oc apply -f kubernetes.yaml
oc get pods
oc get routes
```
