mkspec
======

A small tool for creating matching spec & production code files.

Note: This is only tested on OSX.
Its tests and the included shell test framework use `mktemp` flags that are platform-dependant.


Usage
-----

`mkspec app/lib/foo.rb`  
Now you have an empty file at `app/lib/foo.rb`,
and an RSpec file at `spec/lib/foo.rb`.

`mkspec tools/script.sh`  
Now you have an empty script at `tools/script.sh`,
and a shell spec file at `spec/tools/script.sh`


Installation
------------

1. Get mkspec on your path somehow.
2. Make sure the `support` folder is a sibling of mkspec
3. Make some specs


Spec Templates
--------------

###Ruby
The spec template for ruby only has an empty RSpec describe block.

###Bash
I've included a very small test framework for script testing.
It creates an empty temporary directory as the pwd, and clears it between tests.
Tests look like this:

    it 'creates some file'
      some_command
      test -f some_file
    check

The `it` function stores off a string to display when the test passes or fails.
The `check` function checks the return code of the last command and prints
the pass or fail message (then empties the working directory).

###Other
I'll likely be making javascript and coffescript templates as well.


Little Things
-------------

To match Rails conventions, mkspec doesn't create an app folder directly under spec.

The included shell test framework adds a file `spec/shpec`.
It won't overwrite this file if it's already there.

