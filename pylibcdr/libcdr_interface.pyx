# distutils: language = c++

from libcpp.string cimport string

cdef extern from "core/parser.h":
    string svg(char* file)

def parse(f_name):
    f_name = f_name.encode()
    cdef char* name = f_name
    res = string(svg(name)).decode()
    # parser.cxx returns strings prefixed with "ERROR" (e.g. "ERROR: ...")
    # on all failure paths, so this prefix is a reliable sentinel.
    if res.startswith("ERROR"):
        raise CDRException(res)
    return res

class CDRException(Exception):
    pass
