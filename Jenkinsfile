pipeline{
            agent any
            stages{
                    stage('--Front End--'){
                            steps{
                                    sh '''
                                            image="10.0.1.50:5000/frontend:build-$BUILD_NUMBER"
                                            docker build -t $image /var/lib/jenkins/workspace/DnD_master/frontend
                                            docker push $image
                                            ssh 10.0.1.51 -oStrictHostKeyChecking=no  << EOF
                                            docker service update --image $image DnDCharacterGen_frontend
                                    '''
                            }
                    }  
     
                    stage('--Back End--'){
                            steps{
                                    sh '''
                                            image="10.0.1.50:5000/backend:build-$BUILD_NUMBER"
                                            docker build -t $image /var/lib/jenkins/workspace/DnD_master/backend
                                            docker push $image
                                            ssh 10.0.1.51 -oStrictHostKeyChecking=no  << EOF
                                            docker service update --image $image DnDCharacterGen_backend
                                    '''
                            }
                    }
                    stage('--Clean up--'){
                            steps{
                                    sh '''
                                            ssh 10.0.1.51 -oStrictHostKeyChecking=no  << EOF
                                            docker system prune
                                    '''
                            }
                    }
            }
    }
