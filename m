From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Trivial hdsp.c patch to support rev 50 cards
Date: Mon, 4 Aug 2003 11:03:17 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGEEFJCOAB.mknecht@controlnet.com>
References: <200308041755.h74Htgdv017691@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200308041755.h74Htgdv017691@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
> i haven't used the hdsp9652 very much, and i certainly don't ever use
> it with aplay. i don't use aplay for anything, really. i've used it
> for periods of time with ardour+JACK, but i am mostly using the
> hdsp+digiface that is present as well.

I understand. Thanks.

I only have used aplay for test purposes, and really would like to request
that you test both mono and stereo wave files using  aplay just to see if
you have the same problems I do. Thanks.

>
> as a side, i must note that i have a bad feeling about ALSA on SMP
> systems right now as well. running JACK with SCHED_FIFO seems to be
> relatively capable of inducing system lockups at the moment. without
> SCHED_FIFO, it seems OK. this is running the Planet 2.4.21 kernel on a
> dual PII.

Unfortunately I cannot do any of this anymore as the current HDSP 9652
driver just doesn't work for me at all.

Thanks for the info though.

Cheers,
Mark




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
