From: Martin Langer <martin-langer@gmx.de>
Subject: Tascam US-224 support
Date: Mon, 16 Feb 2004 22:23:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040216212352.GA566@tuba.home>
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
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, David <david@robot-droid.com>
List-Id: alsa-devel@alsa-project.org


Hi,

I vote for applying both Tascam US-224 patches:

http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg11281.html
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg11311.html

David Coulm has reported that the US-224 works now. The US-224 depends
on usx2yloader like the other two guys called us122 and us428. The us224 is a
controller device like the us428 and so it also depends on the us428control
utility. 

BTW: I don't insist on renaming us428control, but probably it would avoid
a few bugreports... 


bye,
martin

-- 


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
