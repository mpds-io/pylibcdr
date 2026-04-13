cmake_minimum_required(VERSION 3.16)
project(CDR_interface VERSION 0.1.1)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
find_package(Python COMPONENTS Interpreter Development REQUIRED)
find_package(libcdr REQUIRED)
find_package(librevenge REQUIRED)

# Transpile .pyx into C++ at build time; re-runs only when the .pyx changes
add_custom_command(
    OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/libcdr_interface.cpp"
    COMMAND "${Python_EXECUTABLE}" -m cython --cplus
            "${CMAKE_CURRENT_SOURCE_DIR}/libcdr_interface.pyx"
            -o "${CMAKE_CURRENT_BINARY_DIR}/libcdr_interface.cpp"
    DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/libcdr_interface.pyx"
    COMMENT "Cythonizing libcdr_interface.pyx"
    VERBATIM
)

Python_add_library(libcdr_interface MODULE
    "${CMAKE_CURRENT_BINARY_DIR}/libcdr_interface.cpp"
    core/parser.cxx
)
target_include_directories(libcdr_interface PRIVATE
    "${CMAKE_CURRENT_SOURCE_DIR}"
    "${CMAKE_CURRENT_BINARY_DIR}"
    ${LIBCDR_INCLUDE_DIRS}
    ${LIBREVENGE_INCLUDE_DIRS}
)
target_link_libraries(libcdr_interface PRIVATE
    ${LIBCDR_LIBRARY}
    ${LIBREVENGE_LIBRARIES}
)

install(TARGETS libcdr_interface DESTINATION pylibcdr)
