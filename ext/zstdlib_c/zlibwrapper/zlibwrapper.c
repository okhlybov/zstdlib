/* Additional required wrappers not covered by zstd's zlibwrapper */

#include <zlib.h>

#include "zstd_zlibwrapper.h"

ZEXTERN int ZEXPORT z_inflateSyncPoint OF((z_streamp a))
{
  return inflateSyncPoint(a);
}