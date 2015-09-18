from ztrie import *

class MountPoint(object):
    def __init__(self):
        self.type = "mountpoint"

    def get(self, name):
        print "%s:%s(%s)" % (self.type, "get", name)
    def set(self, name):
        print "%s:%s(%s)" % (self.type, "set", name)

class RedisPlugin(MountPoint):
    def __init__(self):
        self.type = "redis"

class IniPlugin(MountPoint):
    def __init__(self):
        self.type = "ini"

class ZconfigPlugin(MountPoint):
    def __init__(self):
        self.type = "zconfig"


redis_plugin = RedisPlugin()
ini_plugin = IniPlugin()
z = Ztrie()

z.insert_route("/foo/bar", 42)
z.insert_route("/config/redis/*", redis_plugin)
z.insert_route("/config/ini/*", ini_plugin)
assert(z.matches("/foo/bar"))
assert(not z.matches("/foo/baz"))
assert(z.matches("/config/redis/key"))
print z.asterisk_match()
assert(z.matches("/config/redis/key/value"))
print z.asterisk_match()
assert(z.hit_data()== redis_plugin)
r = z.hit_data()
if isinstance(r, MountPoint):
    r.get(z.asterisk_match())
assert(z.matches("/foo/bar"))
print z.asterisk_match()
assert(z.hit_data() == 42)
assert(isinstance(redis_plugin, MountPoint))

assert(z.matches("/config/ini/section/key/value"))
print z.asterisk_match()
assert(z.hit_data()== ini_plugin)
r = z.hit_data()
if isinstance(r, MountPoint):
    r.get(z.asterisk_match())

z.show()
