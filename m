From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] echomixer update 4/4
Date: Sun, 16 Jan 2005 20:01:28 +0100
Message-ID: <20050116200128.560cb62c.pochini@shiny.it>
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


- Changes version from 1.0.3 to 1.0.4



Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-tools/echomixer/configure.in_old	Wed Dec 29 14:02:53 2004
+++ alsa-tools/echomixer/configure.in	Sun Jan  9 19:27:23 2005
@@ -1,6 +1,6 @@
 dnl Process this file with autoconf to produce a configure script.
 AC_INIT(echomixer.c)
-AM_INIT_AUTOMAKE(echomixer, 1.0.3)
+AM_INIT_AUTOMAKE(echomixer, 1.0.4)
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC
--- alsa-tools/echomixer/configure.in-gtk2_old	Wed Dec 29 14:02:53 2004
+++ alsa-tools/echomixer/configure.in-gtk2	Sun Jan  9 19:28:55 2005
@@ -1,5 +1,5 @@
 AC_INIT(echomixer.c)
-AM_INIT_AUTOMAKE(echomixer, 1.0.3)
+AM_INIT_AUTOMAKE(echomixer, 1.0.4)
 AC_PROG_CC
 AC_PROG_INSTALL
 AC_HEADER_STDC



--
Giuliano.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
