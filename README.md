Parser for the LPF phase diagram CDR drawings 
==========

## Installation

First, the patched `libcdr` must be compiled. On Debian, after Andrey's patch has been accepted:

```
apt-get install automake cmake libtool libboost-all-dev libicu-dev liblcms2-dev librevenge-dev libcppunit-dev zlib1g-dev
git clone https://git.libreoffice.org/libcdr
cd libcdr
./autogen.sh
./configure
make && make install
```

Then: `pip install git+https://bitbucket.org/tilde-mi/pylibcdr`

## Usage

```
import sys
from pylibcdr import parse
print(parse(sys.argv[1]))
```