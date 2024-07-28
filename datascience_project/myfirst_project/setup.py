import os
from setuptools import setup, find_packages

setup(
    name="myfirst_project",
    version = os.getenv('PACKAGE_VERSION', '0.0.1'),
    packages=find_packages(),
    install_requires=[
        # List your project dependencies here
    ],
    entry_points={
        'console_scripts': [
            'hello-world=myfirst_project.module1:main',
        ],
    },
)
