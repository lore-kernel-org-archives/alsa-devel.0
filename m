From: Christian Esken <c.esken@cityweb.de>
Subject: Re: cs64xx distortion (GameTheater XP)
Date: Sat, 18 Jan 2003 12:13:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301181213.56670.c.esken@cityweb.de>
References: <200301160014.11787.c.esken@cityweb.de> <3E273C33.9050905@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E273C33.9050905@cucumelo.org>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Friday 17 January 2003 00:11 schrieb Benny Sjostrand:
> >I wonder what the status of the cs64xx distortion problem is.
> >I tested the 2003-01-14.tar.bz2 snapshot with my GameThaeter 7.1 XP
>
> My opinion: the GameTheater XP it's a cheap soundcard with a beautiful
> blue box. Usually cheap soundcard got a cheap design as result of a tiny
> bugdet, so just dont expect to much from the analog part's.

I don't buy this opinion! Measurements published in sound card tests show
a pretty good sound quality.

But apart from that: The sound quality in Linux has NOTHING to do with
the capabilities of the card (as it has no problems under Windwos):
- Sound quality of the card: good (or fair or whatever you like)
- Sound quality under Linux: very very very very bad.

> Actually I got a Hercules GameTheater XP 6.1, when volume is over about
> a ~80% the output is sometimes distorcionated, but I believe that's
> something we cant do anything about in the driver. Limit some volume
> control's in the driver dont feel like a coherent solution.
>
> The card is still usable, I really dont expect to better quality on
> analog output with this soundcard.

Alas - my GameTheater XP 7.1 is not (except digital output).

So if this problem is a known issue, sholdn't there be a hint in the
Alsa Sound Card Matrix. I don't blame anybody (except perhaps
CS), but I think others should be warned on possible problems.

Chris




-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com - A 128-bit supercerts will
allow you to extend the highest allowed 128 bit encryption to all your 
clients even if they use browsers that are limited to 40 bit encryption. 
Get a guide here:http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0030en
