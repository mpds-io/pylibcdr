Python bindings for libcdr
==========

[![DOI](https://zenodo.org/badge/468935999.svg)](https://doi.org/10.5281/zenodo.7692820)
[![PyPI](https://img.shields.io/pypi/v/pylibcdr.svg?style=flat)](https://pypi.org/project/pylibcdr)

## Intro

Simple Python bindings for the [libcdr](https://wiki.documentfoundation.org/DLP/Libraries/libcdr). The binding chain is:

```
Python (CDRParser) → Cython (.pyx) → C++ (parser.cxx) → libcdr / librevenge
```


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

The build steps (orchestrated automatically):
1. CMake configures using `pylibcdr/CMakeLists.txt`.
2. CMake invokes Cython to transpile `libcdr_interface.pyx` into `libcdr_interface.cpp` (via `add_custom_command`).
3. CMake compiles the generated `.cpp` and `core/parser.cxx` into the Python extension `libcdr_interface` (via `Python_add_library`), linking against `libcdr` and `librevenge`.

If CMake fails, delete any `_skbuild/` or `build/` temp directories before retrying.


## Usage

```
import sys
from pylibcdr import CDRParser
parser = CDRParser(sys.argv[1])
print(parser.xml)   # raw XHTML/SVG string
print(parser.dict)  # parsed as a nested dict
```


## Architecture

| File | Role |
|------|------|
| `pylibcdr/__init__.py` | `CDRParser` class; converts XML string to dict via `dictify()` |
| `pylibcdr/libcdr_interface.pyx` | Cython bridge; calls `svg(char*)` from C++, raises `CDRException` on error strings |
| `pylibcdr/core/parser.cxx` | C++ core; uses `libcdr`/`librevenge` to parse CDR files, returns XHTML wrapping SVG pages |
| `pylibcdr/core/parser.h` | Header declaring `std::string svg(char* file)` |
| `pylibcdr/CMakeLists.txt` | CMake build: Cython transpilation + `Python_add_library` for the extension |
| `pylibcdr/cmake/` | Custom `Find*.cmake` modules for `libcdr` and `librevenge` |
| `pyproject.toml` | Project metadata and scikit-build-core configuration |

The C++ `svg()` function returns an error string prefixed with `"ERROR"` on failure; the Cython layer detects this and raises `CDRException`.

The output of `svg()` is XHTML wrapping one or more SVG documents (one per page). `CDRParser.xml` exposes this raw string; `CDRParser.dict` parses it with `xml.etree.ElementTree` into a nested dict where repeated child tags become lists.


## License

Inherited from the `libcdr` (MPL 2.0).
