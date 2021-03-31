import sys

from . import common, utils

utils.patch_pysexp_module_for_version(common, sys.version_info)

main = common.main
