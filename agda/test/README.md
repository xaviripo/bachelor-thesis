# `test` module

This module contains a few tests used to check that the installation works correctly. The tests are taken from the [HoTT/HoTT-Agda GitHub repository](https://github.com/HoTT/HoTT-Agda/tree/master/test/succeed). The authorship of the code contained in this folder, other than this file, is specified in `LICENSE.md`.

In order to run the tests, just pass this file to Agda, like so:

    ./agda/run.sh agda/test/Test.agda -- --library hott-core