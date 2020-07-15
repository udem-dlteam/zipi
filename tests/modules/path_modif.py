import package1
package1.__path__ = [package1.__path__[0] + "/.."] + package1.__path__
import package1.package1
