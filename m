From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] 5/5 echomixer subversion++
Date: Sun, 3 Apr 2005 15:42:50 +0200
Message-ID: <20050403154250.08d05ecd.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



- Subversion++.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-tools/echomixer/configure.in__orig	Sun Apr  3 15:37:04 2005
+++ alsa-tools/echomixer/configure.in	Sun Apr  3 15:37:22 2005
@@ -1,6 +1,6 @@
 dnl Process this file with autoconf to produce a configure script.
 AC_INIT(echomixer.c)
-AM_INIT_AUTOMAKE(echomixer, 1.0.4)
+AM_INIT_AUTOMAKE(echomixer, 1.0.5)
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
--- alsa-tools/echomixer/configure.in-gtk2__orig	Sun Apr  3 15:37:10 2005
+++ alsa-tools/echomixer/configure.in-gtk2	Sun Apr  3 15:37:30 2005
@@ -1,5 +1,5 @@
 AC_INIT(echomixer.c)
-AM_INIT_AUTOMAKE(echomixer, 1.0.4)
+AM_INIT_AUTOMAKE(echomixer, 1.0.5)
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC



--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
