import os
from setuptools import setup, Extension
from setuptools.command.build_ext import build_ext as build_extension

import six
if six.PY2:
    import pathlib2 as pathlib
else:
    import pathlib

# check for Cython version
try:
    from Cython import __version__ as cython_version
    assert cython_version > "0.15"
    use_cython = True
    ext = ".pyx"
except (ImportError, AssertionError):
    use_cython = False
    ext = ".cpp"

class CMakeExtension(Extension, object):

    def __init__(self, name):
        # don't invoke the original build_ext for this special extension
        super(CMakeExtension, self).__init__(name, sources=[])


class build_ext(build_extension, object):

    def run(self):
        for ext in self.extensions:
            self.build_cmake(ext)
        super(build_ext, self).run()

    def build_cmake(self, ext):
        root = str(pathlib.Path().absolute())

        # these dirs will be created in build_py, so if you don't have
        # any python sources to bundle, the dirs will be missing
        build_temp = pathlib.Path(self.build_temp)
        build_temp.mkdir(parents=True, exist_ok=True)
        ext_path = self.get_ext_fullpath(ext.name) + '_' if six.PY2 else self.get_ext_fullpath(ext.name)
        extdir = pathlib.Path(ext_path)
        extdir.mkdir(parents=True, exist_ok=True)
        # example of cmake args
        config = 'Debug' if self.debug else 'Release'
        cmake_args = [
            '-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=' + str(extdir.parent.absolute()),
            '-DCMAKE_BUILD_TYPE=' + config
        ]

        # example of build args
        build_args = [
            '--config', config,
            '--', '-j4'
        ]
        os.chdir(str(build_temp))
        self.spawn(['cmake', os.path.join(root, 'pylibcdr')] + cmake_args)
        if not self.dry_run:
            self.spawn(['cmake', '--build', '.'] + build_args)
        # Troubleshooting: if fail on line above then delete all possible
        # temporary CMake files including "CMakeCache.txt" in top level dir.
        os.chdir(root)

# cythonize pyx file if right version of Cython is found
if use_cython:
    from Cython.Build import cythonize
    pyx_ext = Extension("libcdr_interface",
              sources=["pylibcdr/libcdr_interface" + ext],
              include_dirs=["pylibcdr/core"],
              language="c++",
              )
    cythonize(pyx_ext, compiler_directives={'language_level' : "3"})

setup(
    name="pylibcdr",
    version="0.1.0",
    description="A wrapper around libcdr library.",
    author="Andrey Sobolev",
    author_email="andrey.n.sobolev@gmail.com",
    url="",
    download_url="",
    packages=["pylibcdr"],
    package_dir={"pylibcdr": "pylibcdr"},
    ext_modules=[CMakeExtension("pylibcdr/libcdr_interface"),],
    cmdclass={
        'build_ext': build_ext,
    }
)