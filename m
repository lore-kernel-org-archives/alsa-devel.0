From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: devfs_remove() not present in linux 2.4.19
Date: Sat, 23 Nov 2002 17:37:59 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021123173759.35911.qmail@web40612.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I am having problems with the latest ALSA CVS using
Linux 2.4.19-SMP and devfs. Specifically:

# depmod -ae
depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/drivers/sound/snd.o
depmod:         devfs_remove

Cheers,
Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
