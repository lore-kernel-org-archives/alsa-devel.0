From: jgotts@linuxsavvy.com
Subject: Re: PATCH] SPDIF out clock sync for via8235 / ALC650
Date: Sun, 02 Feb 2003 07:03:02 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302021203.h12C32409925@ann-arbor.fmfts.com>
References: <200212302130.gBULUVp24791@ann-arbor.fmfts.com>
Reply-To: jgotts@linuxsavvy.com
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 30 Dec 2002 16:30:31 EST."
             <200212302130.gBULUVp24791@ann-arbor.fmfts.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ae.tech@noos.fr, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In message <200212302130.gBULUVp24791@ann-arbor.fmfts.com>, jgotts@linuxsavvy.c
om writes:

>I have produced a minimal patch based upon your work in CVS to get the SPDIF
>port going on A7V8X motherboards with 0.9.0rc6 until 0.9.0rc7 is released:

I'm not sure what went wrong with 0.9.0rc7, but SPDIF output still doesn't
work with my chipset.  The patch only had cosmetic changes in the 0.9.0rc7
release, so something must have been broken between the CVS tree as of December
30th and the 0.9.0rc7 release.

The line out does work...

John

-- 
John GOTTS <jgotts@linuxsavvy.com>  http://linuxsavvy.com/staff/jgotts


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
