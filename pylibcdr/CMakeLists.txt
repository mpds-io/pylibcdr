cmake_minimum_required(VERSION 3.0.0)
project(CDR_interface VERSION 0.1.0)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
find_package (PythonInterp ${PYTHON_VERSION} REQUIRED)                                   
find_package (PythonLibs ${PYTHON_VERSION} REQUIRED)                                     
# find_package (Python COMPONENTS Interpreter Development REQUIRED)     
find_package(libcdr REQUIRED)
find_package(librevenge REQUIRED)
include_directories(${LIBCDR_INCLUDE_DIRS} ${LIBREVENGE_INCLUDE_DIRS} ${PYTHON_INCLUDE_DIRS})
add_library(cdr_interface SHARED libcdr_interface.cpp core/parser.cxx ${libcdr})
target_link_libraries(cdr_interface ${LIBCDR_LIBRARY} ${LIBREVENGE_LIBRARIES})

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
