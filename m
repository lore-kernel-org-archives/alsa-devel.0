From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa cvs broken
Date: Mon, 3 Apr 2006 15:08:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0604031458460.9509@tm8103.perex-int.cz>
References: <44310468.6080303@superbug.co.uk> <s5hr74ec174.wl%tiwai@suse.de>
 <44311356.1000108@superbug.co.uk> <Pine.LNX.4.61.0604031438430.9509@tm8103.perex-int.cz>
 <s5hlkumbz1t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlkumbz1t.wl%tiwai@suse.de>
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
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 3 Apr 2006, Takashi Iwai wrote:

> > Is hg stable enough?
> 
> Yes, it's pretty stable now.
> But if we switch to another one, it'd be better to run both CVS and
> hg/git parallel in a short term for checking the stability and
> usability.
> 
> Another question is which host.  Suggestions?

I can create a hg/git repository on my machine. If we find some trouble 
with it, we can look for another solution.

I must say that git looks too much "kernel" oriented and sometimes 
hard-to-use. Mercurial has my sympatics, because it uses Python (on other 
hand, it might imply some performance issues).

I would start with mercurial and we'll see then.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
