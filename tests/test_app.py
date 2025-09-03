import unittest
from src.app import app
class TestFlaskApp(unittest.TestCase):
    def setUp(self):
        app.config['TESTING'] = True
        self.client = app.test_client()
    def test_root_route(self):
        # 测试根路由：状态码 200 + 返回预期内容
        response = self.client.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data.decode('utf-8'), 'Hello, WSL Jenkins!')
if __name__ == '__main__':
    unittest.main(verbosity=2)