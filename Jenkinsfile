pipeline{
            agent any
            stages{
                    stage('--Front End--'){
                            steps{
                                    sh '''
                                    ssh -i /home/jenkins/.ssh/ssh-aws-pc ubuntu@10.0.1.51 << EOF
                                        git clone --branch dev-peter-jon git@github.com:jpqa1/BAE-sfia2-brief.git
                                        cd ./BAE-sfia2-brief
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

