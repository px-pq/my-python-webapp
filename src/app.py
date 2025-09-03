from flask import Flask
# 创建 Flask 应用，WSL 需指定 host=0.0.0.0 允许 Windows 访问
app = Flask(__name__)
@app.route('/')
def hello_wsl():
    return 'Hello, WSL Jenkins!'  # 自定义返回内容，便于验证部署
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)  # 端口 5000，关闭 debug