From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: problem compiling alsa-lib CVS.
Date: Mon, 22 Mar 2004 16:53:21 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <405F1A01.8080408@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060005050408080002080604"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net [194.217.242.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA07621
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2004 17:49:24 +0100
Received: from superbug.demon.co.uk ([80.176.146.252])
	by anchor-post-31.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1B5Sc3-000DCx-0V
	for alsa-devel@alsa-project.org; Mon, 22 Mar 2004 16:49:19 +0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060005050408080002080604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I attach the output I see on the screen when running ./cvscompile.

Cheers
James

--------------060005050408080002080604
Content-Type: text/plain;
 name="error.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="error.txt"

Script started on Mon Mar 22 16:50:52 2004
sh-2.05b# ./cvscompile
automake-1.5: configure.in: installing `./install-sh'
automake-1.5: configure.in: installing `./mkinstalldirs'
automake-1.5: configure.in: installing `./missing'
automake-1.5: configure.in: installing `./depcomp'
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/lang-compile.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/lang-compile.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/lang-compile.am: AMDEP does not appear in AM_CONDITIONAL
src/Makefile.am:21: invalid unused variable name: `AM_LDFLAGS'
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/lang-compile.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/lang-compile.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/lang-compile.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/lang-compile.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/lang-compile.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/lang-compile.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/lang-compile.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/lang-compile.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/lang-compile.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/lang-compile.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/lang-compile.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/lang-compile.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/lang-compile.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/lang-compile.am: AMDEP does not appear in AM_CONDITIONAL
automake-1.5: configure.in: installing `./compile'
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/depend2.am: AMDEP does not appear in AM_CONDITIONAL
/usr/share/automake-1.5/am/lang-compile.am: AMDEP does not appear in AM_CONDITIONAL
CFLAGS=-O2 -Wall -W -pipe -g
./configure 
checking build system type... i686-pc-linux-gnu
checking host system type... i686-pc-linux-gnu
checking target system type... i686-pc-linux-gnu
checking for a BSD-compatible install... /bin/install -c
checking whether build environment is sane... yes
checking whether make sets $(MAKE)... yes
checking for working aclocal-1.4... found
checking for working autoconf... found
checking for working automake-1.4... found
checking for working autoheader... found
checking for working makeinfo... found
checking for gcc... gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables... 
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ANSI C... none needed
checking for a BSD-compatible install... /bin/install -c
checking whether ln -s works... yes
checking for a sed that does not truncate output... /bin/sed
checking for egrep... grep -E
checking for ld used by gcc... /usr/i686-pc-linux-gnu/bin/ld
checking if the linker (/usr/i686-pc-linux-gnu/bin/ld) is GNU ld... yes
checking for /usr/i686-pc-linux-gnu/bin/ld option to reload object files... -r
checking for BSD-compatible nm... /usr/bin/nm -B
checking how to recognise dependent libraries... pass_all
checking how to run the C preprocessor... gcc -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking dlfcn.h usability... yes
checking dlfcn.h presence... yes
checking for dlfcn.h... yes
checking whether we are using the GNU C++ compiler... yes
checking whether g++ accepts -g... yes
checking how to run the C++ preprocessor... g++ -E
checking for g77... no
checking for f77... no
checking for xlf... no
checking for frt... no
checking for pgf77... no
checking for fort77... no
checking for fl32... no
checking for af77... no
checking for f90... no
checking for xlf90... no
checking for pgf90... no
checking for epcf90... no
checking for f95... no
checking for fort... no
checking for xlf95... no
checking for ifc... no
checking for efc... no
checking for pgf95... no
checking for lf95... no
checking for gfortran... no
checking whether we are using the GNU Fortran 77 compiler... no
checking whether  accepts -g... no
checking the maximum length of command line arguments... 32768
checking command to parse /usr/bin/nm -B output from gcc object... ok
checking for objdir... .libs
checking for ar... ar
checking for ranlib... ranlib
checking for strip... strip
checking if gcc static flag  works... yes
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fPIC
checking if gcc PIC flag -fPIC works... yes
checking if gcc supports -c -o file.o... yes
checking whether the gcc linker (/usr/i686-pc-linux-gnu/bin/ld) supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking for shl_load... no
checking for shl_load in -ldld... no
checking for dlopen... no
checking for dlopen in -ldl... yes
checking whether a program can dlopen itself... yes
checking whether a statically linked program can dlopen itself... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
configure: creating libtool
appending configuration tag "CXX" to libtool
checking for ld used by g++... /usr/i686-pc-linux-gnu/bin/ld
checking if the linker (/usr/i686-pc-linux-gnu/bin/ld) is GNU ld... yes
checking whether the g++ linker (/usr/i686-pc-linux-gnu/bin/ld) supports shared libraries... yes
checking for g++ option to produce PIC... -fPIC
checking if g++ PIC flag -fPIC works... yes
checking if g++ supports -c -o file.o... yes
checking whether the g++ linker (/usr/i686-pc-linux-gnu/bin/ld) supports shared libraries... yes
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking for shl_load... (cached) no
checking for shl_load in -ldld... (cached) no
checking for dlopen... (cached) no
checking for dlopen in -ldl... (cached) yes
checking whether a program can dlopen itself... (cached) yes
checking whether a statically linked program can dlopen itself... (cached) yes
appending configuration tag "F77" to libtool
./configure: line 18961: test: too many arguments
checking for ANSI C header files... (cached) yes
checking for an ANSI C-conforming const... yes
checking for inline... inline
checking whether time.h and sys/time.h may both be included... yes
checking whether gcc needs -traditional... no
checking for hsearch_r... yes
checking for library version... major 1 minor 0 subminor 3 extrastr b extraver 1000000
checking for versioned symbols... yes
checking for debug... yes
checking for tmpdir... /tmp
checking for softfloat... no
checking for architecture... x86
Making a symlink include/alsa
configure: creating ./config.status
config.status: creating Makefile
config.status: creating doc/Makefile
config.status: creating doc/pictures/Makefile
config.status: creating include/Makefile
config.status: creating include/sound/Makefile
config.status: creating src/Makefile
config.status: creating src/control/Makefile
config.status: creating src/mixer/Makefile
config.status: creating src/ordinary_mixer/Makefile
config.status: creating src/pcm/Makefile
config.status: creating src/pcm/ext/Makefile
config.status: creating src/pcm/scopes/Makefile
config.status: creating src/ordinary_pcm/Makefile
config.status: creating src/rawmidi/Makefile
config.status: creating src/timer/Makefile
config.status: creating src/hwdep/Makefile
config.status: creating src/seq/Makefile
config.status: creating src/instr/Makefile
config.status: creating src/compat/Makefile
config.status: creating src/alisp/Makefile
config.status: creating src/conf/Makefile
config.status: creating src/conf/cards/Makefile
config.status: creating src/conf/pcm/Makefile
config.status: creating alsalisp/Makefile
config.status: creating aserver/Makefile
config.status: creating test/Makefile
config.status: creating utils/Makefile
config.status: creating utils/alsa-lib.spec
config.status: creating utils/alsa.pc
config.status: creating include/config.h
config.status: executing default-1 commands
Making all in doc
make[1]: Entering directory `/u/alsacvs/alsa-lib/doc'
Making all in pictures
make[2]: Entering directory `/u/alsacvs/alsa-lib/doc/pictures'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/u/alsacvs/alsa-lib/doc/pictures'
make[2]: Entering directory `/u/alsacvs/alsa-lib/doc'
make[2]: Nothing to be done for `all-am'.
make[2]: Leaving directory `/u/alsacvs/alsa-lib/doc'
make[1]: Leaving directory `/u/alsacvs/alsa-lib/doc'
Making all in include
make[1]: Entering directory `/u/alsacvs/alsa-lib/include'
make  all-recursive
make[2]: Entering directory `/u/alsacvs/alsa-lib/include'
Making all in sound
make[3]: Entering directory `/u/alsacvs/alsa-lib/include/sound'
make[3]: Nothing to be done for `all'.
make[3]: Leaving directory `/u/alsacvs/alsa-lib/include/sound'
make[3]: Entering directory `/u/alsacvs/alsa-lib/include'
Updating version.h
make[3]: Leaving directory `/u/alsacvs/alsa-lib/include'
make[2]: Leaving directory `/u/alsacvs/alsa-lib/include'
make[1]: Leaving directory `/u/alsacvs/alsa-lib/include'
Making all in src
make[1]: Entering directory `/u/alsacvs/alsa-lib/src'
Makefile:204: *** missing separator.  Stop.
make[1]: Leaving directory `/u/alsacvs/alsa-lib/src'
make: *** [all-recursive] Error 1
sh-2.05b# exit
exit

Script done on Mon Mar 22 16:51:23 2004

--------------060005050408080002080604--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
