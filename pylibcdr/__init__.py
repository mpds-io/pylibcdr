# This file is a part of pylibcdr project (c) Andrey Sobolev, 2020
# Distributed under MIT license

from .libcdr_interface import parse, CDRException
from xml.etree import ElementTree as ETree
from copy import copy

__all__ = ["CDRParser", "CDRException"]

class CDRParser:

    def __init__(self, file_name):
        self._file_name = file_name
        self._xml = parse(file_name)
        self._content = self._parse_xml()

    def __repr__(self):
        return "{}({!r})".format(self.__class__.__name__, self._file_name)

    @property
    def xml(self):
        return self._xml

    @property
    def dict(self):
        return self._content

    def _parse_xml(self):
        root = ETree.fromstring(self._xml)
        return dictify(root)


def dictify(r, root=True):
    if root:
        return {r.tag: dictify(r, False)}
    d = copy(r.attrib)
    if r.text:
        # Note: text content on elements that also have children is captured
        # here, but child text nodes (r.tail) are not. For the XHTML/SVG output
        # produced by libcdr this is sufficient, but mixed-content documents
        # would lose tail text.
        d["_text"] = r.text
    for x in r.findall("./*"):
        if x.tag not in d:
            d[x.tag] = []
        d[x.tag].append(dictify(x, False))
    return d
