pipeline {
    agent {
        label "master"
    }
    tools {
        // Note: this should match with the tool name configured in your jenkins instance (JENKINS_URL/configureTools/)
        maven "M2_HOME"
    }

    environment {
        
        NEXUS_VERSION = "nexus3"
        // This can be http or https
        NEXUS_PROTOCOL = "http"
        // Where your Nexus is running
        NEXUS_URL = "172.31.10.224:8081"
        // Repository where we will upload the artifact
        NEXUS_REPOSITORY = "Nexus_Repo"
        // Jenkins credential id to authenticate to Nexus OSS
        NEXUS_CREDENTIAL_ID = "nexus_credentials"
    }
      

     stages {
        stage("getscm") {
            steps {
                script {
                    // Let's clone the source
                    git 'https://github.com/chakradhar1140/demo-CI-CD-.git';

                }
            }
        }

        stage("mvn build") {
            steps {
                script {
                    
                    sh(/${MAVEN_HOME}\bin\mvn -Dmaven.test.failure.ignore clean package/)
                }
            }
        }

        stage("deploy on Tomcat") {
            steps {

        deploy adapters: [tomcat8(credentialsId: 'Tomcat_credentials', 
        path: '', url: 'http://18.216.253.224:8080/')], 
        contextPath: null, 
        onFailure: false, 
        war: '**/*.war'
            }}
        
        stage("publish to nexus") {
            steps {
                script {
                    // Read POM xml file using 'readMavenPom' step , this step 'readMavenPom' is included in: https://plugins.jenkins.io/pipeline-utility-steps
                    pom = readMavenPom file: "pom.xml";
                    // Find built artifact under target folder
                    filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
                    // Print some info from the artifact found
                    echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                    // Extract the path from the File found
                    artifactPath = filesByGlob[0].path;
                    // Assign to a boolean response verifying If the artifact name exists
                    artifactExists = fileExists artifactPath;
                    if(artifactExists) {
                        echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}";
                        nexusArtifactUploader(
                            nexusVersion: NEXUS_VERSION,
                            protocol: NEXUS_PROTOCOL,
                            nexusUrl: NEXUS_URL,
                            groupId: pom.groupId,
                            version: '${BUILD_NUMBER}',
                            repository: NEXUS_REPOSITORY,
                            credentialsId: NEXUS_CREDENTIAL_ID,
                            artifacts: [
                                // Artifact generated such as .jar, .ear and .war files.
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: artifactPath,
                                type: pom.packaging],
                                // Lets upload the pom.xml file for additional information for Transitive dependencies
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: "pom.xml",
                                type: "pom"]
                            ]
                        );
                    } else {
                        error "*** File: ${artifactPath}, could not be found";
                    }
                }
            }
        }

        stage("deploy on Docker host") {
         
              steps {

        sshPublisher(publishers: [sshPublisherDesc(configName: 'docker_host', 
          transfers: [sshTransfer(cleanRemote: false, 
          excludes: '', 
          execCommand: '''docker stop demo;
                          docker rm demo;
                          docker rmi creddy1140/demo;
                          cd /home/dockeradmin;
                          docker build . -t creddy1140/demo 
                       ''', 
          execTimeout: 120000, 
          flatten: false, 
          makeEmptyDirs: false, 
          noDefaultExcludes: false, 
          patternSeparator: '[, ]+', 
          remoteDirectory: '//home//dockeradmin', 
          remoteDirectorySDF: false, 
          removePrefix: 'target/', 
          sourceFiles: 'target/*.war')], 
          usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false), 
        sshPublisherDesc(configName: 'docker_host', transfers: [sshTransfer(cleanRemote: false, excludes: '',
          execCommand: 'docker run -d --name demo -p 8090:8080 creddy1140/demo', execTimeout: 120000, flatten: false, makeEmptyDirs: false, 
          noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], 
          usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])

                     }


                                           } 

     
    
        stage("publish docker image to docker host") {
            agent {
            docker {
           steps {
           
                 sh """
                    docker tag ${IMAGE} ${IMAGE}:${VERSION}
                    docker push ${IMAGE}:${VERSION}
                    """

                  }
                                                     }}}

                                                  


 
}
