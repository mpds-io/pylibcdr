# - Try to find librevenge
# Once done, this will define
#
#  librevenge_FOUND - system has librevenge
#  librevenge_INCLUDE_DIRS - the librevenge include directories
#  librevenge_LIBRARIES - link these to use librevenge

# Include dir
find_path(LIBREVENGE_INCLUDE_DIR
  NAMES librevenge/librevenge.h
  PATHS /usr/include/*
)

# Finally the library itself
find_library(LIBREVENGE_LIBRARY
  NAMES librevenge-0.0.so
)

# Finally the library itself
find_library(LIBREVENGE_STREAM_LIBRARY
  NAMES librevenge-stream-0.0.so
)

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set LIBXML2_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(librevenge DEFAULT_MSG
                                  LIBREVENGE_LIBRARY LIBREVENGE_STREAM_LIBRARY LIBREVENGE_INCLUDE_DIR)

mark_as_advanced(LIBREVENGE_INCLUDE_DIR LIBREVENGE_LIBRARY LIBREVENGE_STREAM_LIBRARY)

set(LIBREVENGE_LIBRARIES ${LIBREVENGE_LIBRARY} ${LIBREVENGE_STREAM_LIBRARY} )
set(LIBREVENGE_INCLUDE_DIRS ${LIBREVENGE_INCLUDE_DIR} )
