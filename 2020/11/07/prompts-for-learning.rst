Prompts for Learning
====================

Some prompts that are useful for learning coding and also systems.

Here's this post as an initial (non-notebook) draft: TODO link

Here's this post as a Jupyter notebook: TODO link


Pytest tests
+++++++++++++
Pytest is the new standard for testing Python code.
Pytest discovers and runs unittest tests and pytest-style tests.


It is easier to be efficient when working with pytest instead of
unittest; though pytest does run unittest tests when it finds
them.

.. code:: bash

    pip install -U pytest

    mkdir ./tests/
    cat > ./tests/test_example.py <<EOF

    data = dict(a=True)

    def test_thing():
        assert "a" in data
        assert data["a"]


    import unittest
    class TestCaseOne(unittest.TestCase):
        def setUp(self):
            self.data = data.copy()

        def test_a_is_true(self):
            self.assertIn("a", self.data)
        self.assertTrue(self.data['a'])
    EOF
    pytest -v ./tests/test_example.py
    pytest -v ./tests/

As pytest tests:

- CI, nbgrader, GitHub Classroom
- locally?

Shapes
+++++++++

Geometric shapes are a widely-understand set of domain objects.

We can learn to write and test functional and object-oriented styles by
coding shapes.

Functional Shapes
-------------------
Functions:

Functional Namespaces
~~~~~~~~~~~~~~~~~~~~~~~~
We name things so that we can find them.
Our API is the names and types we choose for our functions and arguments.

Which of these names would be best for the function that initializes a
data structure (e.g. a ``struct``) that contains the parameters that
describe a Shape?

A. ``create_rectangle()``
B. ``rectangle_create()``
C. ``rectangle__init__()``

Given that we may be reviewing a list of functions
in possibly alphabetically-sorted 
API documentation or IDE sidebars or IDE *tab-completion*
let's take a look at what the API for those related methods could be:


```
create_rectangle()
area_rectangle()
perimeter_rectangle()

rectangle_area()
rectangle_create()
rectangle_perimeter()

rectangle__init__()
rectangle_area()
rectangle_perimeter()
rectangle__del__()
```


Object-Oriented Shapes
------------------------
Classes:

1. ``Rectangle()``
2. ``Square()``
3. ``Shape()``
4. ``Triangle()``

Methods:

- ``.__init__()``
- ``.area()``
- ``.perimeter()``

.. author:: default
.. categories:: none
.. tags:: none
.. comments::
