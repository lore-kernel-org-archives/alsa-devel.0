From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Tascam US-224 support
Date: Tue, 17 Feb 2004 22:41:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040217214133.GC665@tuba.home>
References: <20040216212352.GA566@tuba.home> <s5h4qtpyb1x.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h4qtpyb1x.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Karsten Wiese <annabellesgarden@yahoo.de>, David <david@robot-droid.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 17, 2004 at 04:34:34PM +0100, Takashi Iwai wrote:
> At Mon, 16 Feb 2004 22:23:52 +0100,
> Martin Langer wrote:
> > 
> > I vote for applying both Tascam US-224 patches:
> > 
> > http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg11281.html
> > http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg11311.html
> 
> thanks, now it's on cvs.

alsa-firmware/usx2yloader/usx2y.prepad can be removed now. (That file is 
replaced by us224.prepad and us122.prepad)

> even the usx2y rule would be broken if tascam releases us438 or so...

They should ask us before releasing it :)

martin

-- 


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
