# - Try to find libcdr
# Once done, this will define
#
#  libcdr_FOUND - system has libcdr
#  libcdr_INCLUDE_DIRS - the libcdr include directories
#  libcdr_LIBRARIES - link these to use libcdr

# Include dir
find_path(LIBCDR_INCLUDE_DIR
  NAMES libcdr/libcdr.h
  PATHS /usr/include/* /usr/local/include/*
)

# Finally the library itself
find_library(LIBCDR_LIBRARY
  NAMES libcdr-0.1.so
  PATHS /usr/lib64 /usr/local/lib64
)

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set LIBXML2_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(libcdr DEFAULT_MSG
                                  LIBCDR_LIBRARY LIBCDR_INCLUDE_DIR)

mark_as_advanced(LIBCDR_INCLUDE_DIR LIBCDR_LIBRARY)

set(LIBCDR_LIBRARIES ${LIBCDR_LIBRARY} )
set(LIBCDR_INCLUDE_DIRS ${LIBCDR_INCLUDE_DIR} )
