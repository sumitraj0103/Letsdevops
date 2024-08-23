import unittest
from ds_project.module1 import hello_world

class TestModule1(unittest.TestCase):

    def test_hello_world(self):
        expected_output = "Hello, world! My name is Sumit@@@"
        self.assertEqual(hello_world(), expected_output)

if __name__ == '__main__':
    unittest.main()
