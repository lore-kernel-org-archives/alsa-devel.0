From: Will <walsac2@liam2.demon.co.uk>
Subject: Re: alsa-lib & oss 1.0.3rc1
Date: Tue, 24 Feb 2004 16:59:45 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402241659.QAA28077@liam2.demon.co.uk>
References: <Pine.LNX.4.58.0402212257000.1870@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0402212257000.1870@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela <perex@suse.cz> wrote:
>
>changes. It would be nice, if you can test my changes and report me bugs
>or comments (especially to the new OSS redirector code).
>

What do you think of my bug report on ALSA OSS emulation of /dev/sequencer?
I posted it at http://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=28 but there haven't been any followup posts.
The /dev/sequencer part of the OSS emulation is really very broken.
Do you think it's something you can easily fix?

I find everything except /dev/sequencer is now working well in
the OSS emulation.  I'd like to stop using the old OSS sound drivers
but I need a working /dev/sequencer

William


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
