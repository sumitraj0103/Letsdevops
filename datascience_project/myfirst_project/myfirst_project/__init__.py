# my_project/__init__.py
# my_project/__init__.py

from .module1 import hello_world

# Optionally define a convenient alias
def greet():
    return hello_world()
