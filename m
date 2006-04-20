From: Jaroslav Kysela <perex@suse.cz>
Subject: ALSA HG repos
Date: Thu, 20 Apr 2006 14:54:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0604201437500.10174@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 22E93191
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2006 14:54:31 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi all,

	as you've probably already noted, we're using HG (Mercurial) now.
It is still a testing phase, but we already decided to not use CVS after 
1.0.11. So, starting immediatelly, CVS at SourceForge will be no longer 
updated (I already disabled write access for all ALSA developers there). 
We can eventually shift our repositories to GIT, but actually HG is enough 
for our purposes.
	R/O HG repos are here http://hg-mirror.alsa-project.org . Repos 
are synced with our master server every 5 minutes. On ALSA website, you 
may find also an alternate rsync access. Rsync repositories are synced 
every hour.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
