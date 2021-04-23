pipeline{
            agent any
            stages{
                    stage('--Front End--'){
                            steps{
                                    sh '''
                                    ssh -i /home/jenkins/.ssh/ssh-aws-pc ubuntu@10.0.1.51 << EOF
                                        cd ./BAE-sfia2-brief
                                        git pull
                                        docker-compose down
                                        docker-compose build
                                        docker-compose up -d
EOF
                                    '''
                            }
                    }  
     
        //             stage('--Back End--'){
        //                     steps{
        //                             sh '''

        //                             '''
        //                     }
        //             }
        //             stage('--Database--'){
        //                     steps{
        //                             sh '''

        //                             '''
        //                     }
        //             }
            }
    }

