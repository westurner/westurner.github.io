Teaching Test-Driven-Development First
======================================

Hello world is wrong! Every textbook is doing it wrong, and here's why:

A traditional first hello world program:

.. code:: python

   # helloworld.py

   def hello_world(name):
       return "Hello, {}".format(name)

   if __name__ == "__main__":  # w/o __name__ this'd run inadvertantly
       print(hello_world("@westurner"))

And then run the program:

.. code:: bash

   python ./helloworld.py
   # "It should say 'Hello, @westurner!'"  # (check this manually every time)


Hello world with tests (Test-Driven-Development (TDD)):

.. code:: python

   # test_helloworld.py

   import unittest

   class TestHelloWorld(unittest.Testcase):
       def setUp(self):
           # print("setUp")
           self.data = {'name': 'TestName'}

       def test_hello_world(self, data=None):
           if data is None:
               data = self.data
           name = data['name']
           expected_output = "Hello, {}!".format(name)
           output = hello_world(name)
           assert expected_output == output
           self.assertEqual(ouput, expected_output)

        # def tearDown(self):
        #    print("tearDown")
        #    print(json.dumps(self.data, indent=2))

And then run the automated tests:

.. code:: bash

   python -m site                         # sys.path and $PWD (`pwd`)
   python -m unittest test_helloworld     # ./test_helloworld.py
   python -m unittest -v test_helloworld  # ./test_helloworld.py
   test $? -eq 0 || echo "Tests failed! (nonzero returncode)"

Why should this first run of the tests fail?

- Because we didn't remember to import ``from helloworld import helloworld`` in ``test_helloworld.py``.
- Because, in keeping with TDD, we run the test first to make sure it
  actually fails without our changes.

Advantages of this Test-Driven-Development (TDD) first approach:

- TDD from the start: any future breaking changes will be detected
  (given the completeness of the functional test specification)
- This teaches Object-Orientation (OO) (Encapsulation, Separation of
  Concerns)
- This teaches separation of data and code.
- This teaches Given-When-Then.

And then what? (Teach what next?):

- Testable software design patterns

  - Refactoring: Square, Rectangle, Triangle ``obj.area()``
  - Test factories / test fixtures

- Additional testing tools (beyond ``unittest``):
  
  - pytest
  - Nose
  - WebTest, Selenium, HTML/JSON Parsing
  - https://westurner.github.io/wiki/awesome-python-testing

Concepts and References:

- https://en.wikipedia.org/wiki/%22Hello,_World!%22_program
- https://docs.python.org/2/library/unittest.html

  - https://en.wikipedia.org/wiki/Test-driven_development
  - https://en.wikipedia.org/wiki/Object-oriented_programming

- https://en.wikipedia.org/wiki/Separation_of_concerns
- https://en.wikipedia.org/wiki/Software_design_pattern
- https://en.wikipedia.org/wiki/Given-When-Then

  - https://wrdrd.github.io/docs/consulting/software-development#given-when-then

- https://wrdrd.github.io/docs/consulting/software-development#test-driven-development
- https://westurner.github.io/2013/11/25/hello-world.html



.. author:: default
.. categories:: none
.. tags:: learning, OO, TDD, testing, TST, python
.. comments::
