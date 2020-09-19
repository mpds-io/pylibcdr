# This file is a part of pylibcdr project (c) Andrey Sobolev, 2020
# Distributed under MIT license

from .pylibcdr import parse

class CDRParser:

    def __init__(self, file_name):
        self._content = parse(file_name)

    @property
    def content(self):
        return self._content
