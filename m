From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: Re: Echo driver
Date: Thu, 11 Nov 2004 09:31:48 +0100 (CET)
Message-ID: <XFMail.20041111093148.pochini@shiny.it>
References: <20041111034521.M3689@stickist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041111034521.M3689@stickist.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Yon Mercury <swirlee@stickist.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 11-Nov-2004 Yon Mercury wrote:
> Giuliano,
>
> On Wed, 10 Nov 2004 09:27:10 +0100 (CET), Giuliano Pochini wrote
>> I don't know, but nobody who tried an echoaudio card had success.
>
> Really? Not even you?

I don't have a laptop.


> From the thread, it does seem that different cardbus bridges require special
> tweaks-- but those people seem to be suggesting that it is an issue with the
> Linux PCMCIA implementation and not ALSA. One of their fixes has already been
> implemented into the PCMCIA tree.
>
> What you could do is put out a call for anyone with a CardBus Echo card to
> test your driver. What do you think?

Usually people call me when they have problems. The new driver
have a new firmware and it may make some difference. I'll contact
those people to ask them to try the new driver. I have to finish
it, though, I need some more time. Currently I ported only Darla20,
Gina20, Darla24, Gina24 and Layla20 (no midi yet because I must
rewrite it and I prefer to do that work last).


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
