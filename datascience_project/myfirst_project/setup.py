from setuptools import setup, find_packages

setup(
    name="myfirst_project",
    version="0.2",
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
