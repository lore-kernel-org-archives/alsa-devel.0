From: Martin Langer <martin-langer@gmx.de>
Subject: INSTALL should note that usxyloader depends on alsa-firmware
Date: Sat, 3 Jan 2004 15:30:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040103143054.GA991@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Index: alsa-driver/INSTALL
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/INSTALL,v
retrieving revision 1.152
diff -u -r1.152 INSTALL
--- alsa-driver/INSTALL	4 Dec 2003 11:51:40 -0000	1.152
+++ alsa-driver/INSTALL	3 Jan 2004 14:18:40 -0000
@@ -231,7 +231,7 @@
     This module supports up to 8 cards, autoprobe and hotplugging.
 
     Note: you need to load the firmware via usx2yloader utility included
-          in alsa-tools package.
+          in alsa-tools package and alsa-firmware package.
 
 
   Module snd-au8810, snd-au8820, snd-au8830


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
