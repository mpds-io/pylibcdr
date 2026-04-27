# - Try to find libcdr
# Once done, this will define
#
#  libcdr_FOUND - system has libcdr
#  libcdr_INCLUDE_DIRS - the libcdr include directories
#  libcdr_LIBRARIES - link these to use libcdr

# Try pkg-config first (for include dirs and library paths)
find_package(PkgConfig QUIET)
if(PKG_CONFIG_FOUND)
	pkg_check_modules(LIBCDR_PC QUIET libcdr-0.1)
endif()

# Include dir: versioned subdirectory so #include <libcdr/libcdr.h> works
find_path(LIBCDR_INCLUDE_DIR
	NAMES libcdr/libcdr.h
	HINTS ${LIBCDR_PC_INCLUDE_DIRS}
		/usr/local/include/libcdr-0.1
		/opt/homebrew/include/libcdr-0.1
	PATHS /usr/include/libcdr-0.1
		/usr/local/include/libcdr-0.1
)

# Library: CMAKE prepends 'lib' to NAMES, so use 'cdr-0.1' not 'libcdr-0.1'
find_library(LIBCDR_LIBRARY
	NAMES cdr-0.1
	HINTS ${LIBCDR_PC_LIBRARY_DIRS}
		/usr/local/lib
		/opt/homebrew/lib
	PATHS /usr/lib64
		/usr/local/lib64
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(libcdr DEFAULT_MSG
	LIBCDR_LIBRARY LIBCDR_INCLUDE_DIR)

mark_as_advanced(LIBCDR_INCLUDE_DIR LIBCDR_LIBRARY)

set(LIBCDR_LIBRARIES ${LIBCDR_LIBRARY})
set(LIBCDR_INCLUDE_DIRS ${LIBCDR_INCLUDE_DIR})
