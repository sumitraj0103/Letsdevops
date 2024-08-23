from setuptools import setup, find_packages

setup(
    name="ds_project",
    version="1.3",
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
