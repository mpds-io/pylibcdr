Python bindings for libcdr
==========

[![DOI](https://zenodo.org/badge/468935999.svg)](https://doi.org/10.5281/zenodo.7692820)

## Intro

Simple Python bindings for the [libcdr](https://wiki.documentfoundation.org/DLP/Libraries/libcdr) written by [Dr. Andrey Sobolev](mailto:as@tilde.pro).


## Installation

First, the `libcdr` newer than `v0.1.8` must be compiled.

E.g. on Debian:

```
apt-get install automake cmake libtool libboost-all-dev libicu-dev liblcms2-dev librevenge-dev libcppunit-dev zlib1g-dev
git clone https://git.libreoffice.org/libcdr
cd libcdr
./autogen.sh
./configure
make && sudo make install
```

Then: `pip install git+https://github.com/mpds-io/pylibcdr`


## Usage

```
import sys
from pylibcdr import CDRParser
parser = CDRParser(sys.argv[1])
print(parser.dict)
```


## License

Inherited from the `libcdr` (MPL 2.0).
