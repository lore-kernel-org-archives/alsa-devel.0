From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: The best-supported Pro Audio device?
Date: Thu, 28 Aug 2003 13:59:24 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0308281357350.1958-100000@pnote.perex-int.cz>
References: <XFMail.20030828101338.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20030828101338.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: "ametts2@mindspring.com" <ametts2@mindspring.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Paul Davis <paul@linuxaudiosystems.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Aug 2003, Giuliano Pochini wrote:

> 
> On 28-Aug-2003 Paul Davis wrote:
> >>--*-- What is the best-supported *Pro Audio* device in terms of solid ALSA dri
> >>ver support?  Not interested in Sound Blasters and chips on the motherboard --
> >> something along the lines of the Echo, M-Audio, or RME products.  But the ALS
> >>A drivers need to be stable -- and need to fully support the capabilities of h
> >>e respective device (i.e., on-board DSP, MIDI, or whatever).
> > 
> > the echo drivers are extremely new, and largely untested at this
> > point. they may even be incomplete.
> 
> The Echo driver is complete and tested on most supported cards. All
> features are supported but MIDI and CARDBUS are untested. The driver
> is based on the Windos driver code and that part is stable. The ALSA

Only small note: until someone rewrite the code using the Linux coding 
style and GPL licence, it will not be included to the ALSA main tree,
thus it will not be maintaned by us.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
