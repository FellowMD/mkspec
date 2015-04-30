mkspec
======

A small tool for making matching spec & production code files.

Note: this is only tested on OSX. Specifically it uses `mktemp` flags that I think are platform-dependant.


Usage
-----

`mkspec app/lib/foo.rb`

Now you have an empty file at `app/lib/foo.rb`,
and an RSpec file at `spec/app/lib/foo.rb`.


Installation
------------

1. Get mkspec on your path somehow.
2. Make sure the `support` folder is a sibling of mkspec
3. Make some specs

Spec Templates
--------------

Right now there is only a spec template for ruby with RSpec.
I will likely add a template for javascript BDD with mocha.
I will probably not make it configurable for different test frameworks,
but you can modify the templates if you'd like.
