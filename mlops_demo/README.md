# A guide to build Python Wheels and Run on Azure Databricks

## Introduction
In this tutorial we will learn to create a simple python project, build and package to the wheel file and further deploy to the databricks.

## Prerequsiste

1. Install Python
First, ensure Python is installed on your laptop. You can download the latest version of Python from the official website.https://www.python.org/downloads/
During installation, make sure to check the box that says "Add Python to PATH".

2.  Install Required Packages
```
   pip install setuptools wheel
```

## Create Project Structure

```
myfirst_project/
│
├── myfirst_project/
│   ├── __init__.py
│   ├── module1.py
│   └── module2.py
│
├── tests/
│   ├── __init__.py
│   ├── test_module1.py
│   └── test_module2.py
│
├── setup.py
└── README.md

```
### create module1.py
Add Main Function in module1.py
```
# my_project/module1.py
def hello_world():
    return "Hello, world!"

def main():
    print(hello_world())

if __name__ == "__main__":
    main()

```
### Create setup.py

```
from setuptools import setup, find_packages

setup(
    name="ds_project",
    version="0.1",
    packages=find_packages(),
    install_requires=[
        # List your project dependencies here
    ],
    entry_points={
        'console_scripts': [
            'hello-world=ds_project.module1:main',
        ],
    },
)

```
### Build the Package
```
python setup.py sdist bdist_wheel

```
### Install the package locally
```
pip install dist/ds_project-0.1-py3-none-any.whl

```
### Run the Entry Point

```
hello-world
```

### Additional Command for Debugging

```
-- remove the build
rm -rf build dist my_project.egg-info
-- Verify the Installation
pip show myfirst_project

-- Uninstall
pip uninstall myfirst_project

```
### Running the unit test
```
python -m unittest discover -s tests

```


# Apache Airlfow setup
----------------------installation steps------------------------------

First, make sure you have installed Docker Desktop and Visual Studio. If not, you can do like below

Get Docker: https://docs.docker.com/desktop/insta...

Get Visual Studio Code

Download the following file: https://airflow.apache.org/docs/apach...

Open Visual Studio Code

create a new file .env and add the following lines

AIRFLOW_IMAGE_NAME=apache/airflow:2.4.2
AIRFLOW_UID=50000

docker-compose up -d

create Admin user using below command:

docker-compose run airflow-worker airflow users create --role Admin --username admin --email admin --firstname admin --lastname admin --password admin

http://localhost:8080/