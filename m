From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: alsa cvs broken
Date: Mon, 03 Apr 2006 18:05:32 +0200
Message-ID: <443147CC.40905@keyaccess.nl>
References: <44310468.6080303@superbug.co.uk> <s5hr74ec174.wl%tiwai@suse.de> <44311356.1000108@superbug.co.uk> <Pine.LNX.4.61.0604031438430.9509@tm8103.perex-int.cz> <s5hlkumbz1t.wl%tiwai@suse.de> <Pine.LNX.4.61.0604031458460.9509@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0604031458460.9509@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:

> I must say that git looks too much "kernel" oriented and sometimes 
> hard-to-use. Mercurial has my sympatics, because it uses Python (on
> other hand, it might imply some performance issues).
> 
> I would start with mercurial and we'll see then.

Mind a vote against mercurial, and for GIT? Not because I think GIT is 
necesarily (and at the moment) better -- I in fact don't know either yet 
in any detail.

GIT is the kernel SCM though and unless it's really significantly worse, 
I believe it's better to simply use it. I've been looking to get into 
ALSA a bit for example, and I'd really not appreciate having to learn 
yet another SCM when I'm going to be making use of GIT for all the other 
kernel stuff anyway.

GIT is also still picking up speed. Keith Packard was even converting X 
CVS for example. Mercurial might be good I guess, but it's also very 
likely going to be one of those "oh no, not yet another" ones, maybe 
even keeping potential developers away.

Rene.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
