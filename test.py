import unittest
from app import app

class TestHello(unittest.TestCase):

    def setUp(self):
        app.testing = True
        self.client = app.test_client()

    def test_hello(self):
        username = "Daniel"
        response = self.client.get(f"/sayhello/{username}")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data, b'Hello, Daniel!')

if __name__ == '__main__':
    unittest.main()
