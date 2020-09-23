# distutils: language = c++

from libcpp.string cimport string

cdef extern from "core/parser.h":
    string svg(char* file)

def parse(f_name):
    f_name = f_name.encode()
    cdef char* name = f_name
    res = string(svg(name)).decode()
    if res.startswith("ERROR"):
        raise CDRException(res)
    return res

class CDRException(Exception):
    pass