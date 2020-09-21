# distutils: language = c++

from libcpp.string cimport string

cdef extern from "core/parser.h":
    string svg(char* file)

def parse(f_name):
    f_name = f_name.encode()
    cdef char* name = f_name
    return string(svg(name))