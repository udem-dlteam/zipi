#*=====================================================================*/
#*    serrano/prgm/project/zipi/etc/Makefile                           */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Tue Jul  2 12:57:42 2019                          */
#*    Last change :  Tue Jul  2 13:00:31 2019 (serrano)                */
#*    Copyright   :  2019 Manuel Serrano                               */
#*    -------------------------------------------------------------    */
#*    Zipi etc directory                                               */
#*=====================================================================*/
include Makefile.zipiconfig

install:
	$(INSTALL) pysexp.py $(DESTDIR)$(ZIPIBINDIR)/pysexp-$(ZIPIRELEASE).py
	chmod $(MODEXE) $(DESTDIR)$(ZIPIBINDIR)/pysexp-$(ZIPIRELEASE).py
	(cd $(DESTDIR)$(ZIPIBINDIR) && $(RM) -f pysexp.py && ln pysexp-$(ZIPIRELEASE).py pysexp.py)
