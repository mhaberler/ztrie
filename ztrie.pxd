#from cpython.bool  cimport bool
cdef extern from "czmq.h":

   ctypedef void (*ztrie_destroy_data_fn) (void **data)

   ctypedef struct ztrie_t:
       pass

   ctypedef struct zhashx_t:
       pass


   ztrie_t *ztrie_new (char delimiter)
   int ztrie_insert_route (ztrie_t *self,
                           char *path,
                           void *data,
                           ztrie_destroy_data_fn *destroy_data_fn)
   int  ztrie_remove_route (ztrie_t *self, char *path)
   void ztrie_destroy (ztrie_t **self_p)
   int ztrie_matches (ztrie_t *self, char *path)
   void *ztrie_hit_data (ztrie_t *self)
   char *ztrie_hit_asterisk_match (ztrie_t *self)
   size_t   ztrie_hit_parameter_count (ztrie_t *self)
   zhashx_t *ztrie_hit_parameters (ztrie_t *self)
   void ztrie_print (ztrie_t *self)
