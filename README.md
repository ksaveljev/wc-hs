wc command line tool in Haskell
=====

Usage:

    cabal sandbox init
    cabal install --dependencies-only
    cabal build
    time bash -c "cat file.txt | ./dist/build/wc-hs/wc-hs"

Following a series of tutorial posts by Rodney Lopes Gomes on how to create a
simple clone of *wc* util. The final solution is still not perfect and could be
optimized more. It does run slower than original wc on my Mac OS X for a large
file (with about 2000000 lines), although in the blog post it is said that this
small program runs faster in some cases.

Links to the posts:
* [Writing wc command line tool in Haskell](http://rlgomes.github.io/work/haskell/2011/11/13/13.00-Writing-wc-command-line-tool-in-Haskell.html)
* [Optimizing Haskell Programs](http://rlgomes.github.io/work/haskell/2011/11/14/20.30-Optimizing-Haskell-Programs.html)
