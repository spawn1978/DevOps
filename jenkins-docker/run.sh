docker run -p 8080:8080 -p 50000:50000 --name jenkins-docker jenkins/jenkins
docker exec -it $(docker ps -q|grep jenkins-docker) cat /var/jenkins_home/secrets/initialAdminPassword