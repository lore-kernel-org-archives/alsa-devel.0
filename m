From: Martin Langer <martin-langer@gmx.de>
Subject: Kconfig typo
Date: Thu, 25 Dec 2003 19:22:57 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031225182257.GA535@tuba.home>
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

Index: alsa-driver/pci/Kconfig
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/Kconfig,v
retrieving revision 1.7
diff -u -r1.7 Kconfig
--- alsa-driver/pci/Kconfig	19 Dec 2003 09:19:52 -0000	1.7
+++ alsa-driver/pci/Kconfig	25 Dec 2003 18:15:40 -0000
@@ -15,7 +15,7 @@
         tristate "Aureal Advantage"
         depends on SND
         help
-          Say 'Y' or 'M' to include support for Aureal Advatage soundcards.
+          Say 'Y' or 'M' to include support for Aureal Advantage soundcards.
  
 config SND_AU8820
         tristate "Aureal Vortex"


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
