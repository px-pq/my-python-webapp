pipeline {
    agent any  # 使用 WSL 本地 Jenkins 节点
    triggers {
        pollSCM('H/5 * * * *')  # 每 5 分钟检查 GitHub 代码变更
    }
    stages {
        // 阶段1：拉取 GitHub 代码
        stage('Checkout Code') {
            steps {
                echo "拉取 GitHub 代码..."
                // 替换为你的 GitHub 仓库地址
                git url: 'https://github.com/你的GitHub用户名/my-python-webapp.git',
                    branch: 'main'
            }
        }
        // 阶段2：安装 Python 依赖
        stage('Install Dependencies') {
            steps {
                echo "安装项目依赖..."
                sh 'sudo pip3 install --upgrade pip'
                sh 'sudo pip3 install -r requirements.txt'
            }
        }
        // 阶段3：运行单元测试（失败则终止部署）
        stage('Run Unit Tests') {
            steps {
                echo "运行单元测试..."
                sh 'python3 -m unittest discover -s tests -v'
            }
            post {
                failure {
                    echo "❌ 测试失败，停止部署！"
                }
            }
        }
        // 阶段4：部署到 WSL
        stage('Deploy to WSL') {
            steps {
                echo "部署到 WSL Ubuntu..."
                sh 'chmod +x deploy.sh'  // 赋予执行权限
                sh 'sudo ./deploy.sh'    // 执行部署脚本（需 Jenkins 免密 sudo）
            }
        }
    }
    post {
        always {
            cleanWs()  // 清理 Jenkins 工作空间
        }
        success {
            echo "🎉 全流程执行成功！"
        }
        failure {
            echo "❌ 全流程失败，查看 Console Output 排查问题"
        }
    }
}