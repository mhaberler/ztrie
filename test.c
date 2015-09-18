#include "czmq.h"

int main(int argc, char **argv)
{
    int ret;
    bool hasMatch = false;

    ztrie_t *self = ztrie_new ('/');
    assert (self);

    int foo_bar_data = 10;
    ret = ztrie_insert_route (self, "/config/redis/*", &foo_bar_data, NULL);
    assert (ret == 0);

    hasMatch = ztrie_matches (self, "/config/redis/foo/bar");

    assert (hasMatch);
    assert (streq (ztrie_hit_asterisk_match (self), "foo/bar"));

    int foo_bar_hit_data = *((int *) ztrie_hit_data (self));
    assert (foo_bar_data == foo_bar_hit_data);

    ztrie_print(self);

    return 0;
}
