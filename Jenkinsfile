pipeline{
            agent any
            stages{
                    stage('--Front End--'){
                            steps{
                                    sh '''
                                    ssh -i ssh-aws-pc ubuntu@10.0.1.51 << EOF
                                        git clone git@github.com:jpqa1/BAE-sfia2-brief.git
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

