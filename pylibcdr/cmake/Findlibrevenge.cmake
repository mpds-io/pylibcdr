# - Try to find librevenge
# Once done, this will define
#
#  librevenge_FOUND - system has librevenge
#  librevenge_INCLUDE_DIRS - the librevenge include directories
#  librevenge_LIBRARIES - link these to use librevenge

# Try pkg-config first (for include dirs and library paths)
find_package(PkgConfig QUIET)
if(PKG_CONFIG_FOUND)
	pkg_check_modules(LIBREVENGE_PC QUIET librevenge-0.0)
endif()

# Include dir
find_path(LIBREVENGE_INCLUDE_DIR
	NAMES librevenge/librevenge.h
	HINTS ${LIBREVENGE_PC_INCLUDE_DIRS}
		/usr/local/include/librevenge-0.0
		/opt/homebrew/include/librevenge-0.0
	PATHS /usr/include
		/usr/local/include
)

# Core library - CMake prepends 'lib' to NAMES
find_library(LIBREVENGE_LIBRARY
	NAMES revenge-0.0
	HINTS ${LIBREVENGE_PC_LIBRARY_DIRS}
		/usr/local/lib
		/opt/homebrew/lib
	PATHS /usr/lib64
		/usr/local/lib64
)

# Stream library - CMake prepends 'lib' to NAMES
find_library(LIBREVENGE_STREAM_LIBRARY
	NAMES revenge-stream-0.0
	HINTS ${LIBREVENGE_PC_LIBRARY_DIRS}
		/usr/local/lib
		/opt/homebrew/lib
	PATHS /usr/lib64
		/usr/local/lib64
)

# Generators library - CMake prepends 'lib' to NAMES
find_library(LIBREVENGE_GENERATORS_LIBRARY
	NAMES revenge-generators-0.0
	HINTS ${LIBREVENGE_PC_LIBRARY_DIRS}
		/usr/local/lib
		/opt/homebrew/lib
	PATHS /usr/lib64
		/usr/local/lib64
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(librevenge DEFAULT_MSG
	LIBREVENGE_LIBRARY LIBREVENGE_STREAM_LIBRARY LIBREVENGE_GENERATORS_LIBRARY LIBREVENGE_INCLUDE_DIR)

mark_as_advanced(LIBREVENGE_INCLUDE_DIR LIBREVENGE_LIBRARY LIBREVENGE_STREAM_LIBRARY LIBREVENGE_GENERATORS_LIBRARY)

set(LIBREVENGE_LIBRARIES ${LIBREVENGE_LIBRARY} ${LIBREVENGE_STREAM_LIBRARY} ${LIBREVENGE_GENERATORS_LIBRARY})
set(LIBREVENGE_INCLUDE_DIRS ${LIBREVENGE_INCLUDE_DIR})
