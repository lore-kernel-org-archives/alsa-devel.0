From: Jaroslav Kysela <perex@perex.cz>
Subject: ALSA 1.0.6rc2
Date: Sat, 7 Aug 2004 13:57:59 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408071354310.1780@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8A4711FD
	for <alsa-devel@alsa-project.org>; Sat,  7 Aug 2004 13:59:53 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 555B815B05
	for <alsa-devel@alsa-project.org>; Sat,  7 Aug 2004 13:59:53 +0200 (MEST)
Received: from pnote.perex-int.cz (localhost [127.0.0.1])
	by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 4484B1102F
	for <alsa-devel@alsa-project.org>; Sat,  7 Aug 2004 13:59:53 +0200 (CEST)
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

Hello,

	1.0.6rc2 packages for driver and tools were released. Bellow 
things should be fixed:

* driver
  - usx2y USB driver compilation
  - powermac detection in configure script (--with-cards=powermac)
* tools
  - added back missing hdspmixer

	It might be the last release candidate for 1.0.6.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
