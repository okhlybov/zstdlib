1 i#include <zstd.h>

s/<zlib.h>/<zstd_zlibwrapper.h>/

s/Init_zlib/Init_zstdlib_c/g

s/"\([Zz]\)lib"/"\1stdlib"/g

s/Zlib\(\.\|::\)/Zstdlib\1/g

s/Z_DEFAULT_COMPRESSION/ZSTD_CLEVEL_DEFAULT/g

s/Z_BEST_COMPRESSION/ZSTD_maxCLevel()/g

/rb_define_const.*"ZLIB_VERSION"/a \
  rb_define_const(mZlib, "ZSTD_VERSION", rb_str_new2(ZSTD_versionString())); \
  rb_define_module_function(mZlib, "zstd_version", rb_zstd_version, 0);

/---.*module.*---/a \
\/* \
 * Document-method: Zstdlib.zstd_version \
 * \
 * Returns the string which represents the version of zstd library. \
 *\/ \
  static VALUE \
  rb_zstd_version(VALUE klass) \
  { \
      VALUE str; \
      str = rb_str_new2(ZSTD_versionString()); \
      OBJ_TAINT(str); \
      return str; \
  }
