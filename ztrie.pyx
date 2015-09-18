from .ztrie cimport *
from cpython.string cimport PyString_AsString
from libc.stdlib cimport free

cdef class Ztrie:
    cdef ztrie_t *_ztrie

    def __cinit__(self, char *delimiter="/"):
        self._ztrie = ztrie_new(delimiter[0])
        if self._ztrie == NULL:
            raise Exception, "ztrie_new(%s) failed" % delimiter

    def insert_route(self, char *route, match=None):
        if ztrie_insert_route (self._ztrie, route, <void *>match, NULL):
            raise Exception, "ztrie_insert_route(%s) failed" % route

    def matches(self, char *route):
        return ztrie_matches(self._ztrie, route) == 1

    def asterisk_match(self):
        cdef char *s
        s = ztrie_hit_asterisk_match (self._ztrie)
        if s:
            return  PyString_AsString(s)
        return None

    def hit_data(self):
        return <object>ztrie_hit_data (self._ztrie);

    def show(self):
        ztrie_print(self._ztrie)

    def __dealloc__(self):
        pass #ztrie_destroy(&self._ztrie)
