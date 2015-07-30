#! /bin/sh

coffeelint piano.coffee

# So for example you can pass -w as the first argument to watch the source files
# for any changes and recompile.
coffee -cb $1 -o js piano.coffee
