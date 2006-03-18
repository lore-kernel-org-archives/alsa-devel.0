From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: 2.6.16-rc6: known regressions (v2)
Date: Sat, 18 Mar 2006 14:27:14 -0500
Message-ID: <200603181427.14393.kernel-stuff@comcast.net>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <s5h7j6tt4qx.wl%tiwai@suse.de> <s5hmzfost2h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzfost2h.wl%tiwai@suse.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "S. Umar" <umar@compsci.cas.vanderbilt.edu>, perex@suse.cz, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 17 March 2006 15:40, Takashi Iwai wrote:
> The last patch seems incomplete. =A0Please try the patch below instead.
> (This time with a changelog :)
>
>
> Takashi

Sound works with this patch but now only through the head phones - no sound=
=20
from built-in speakers. Jack sense doesn't seem to work the other way aroun=
d=20
=2D removing head phone doesn't enable speaker output.

Let me know if you need any info.

Thanks!
Parag


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
