From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: anybody else OK with current CVS *and* SMP?
Date: Thu, 07 Aug 2003 10:43:52 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030807104352.pochini@shiny.it>
References: <3F30156D.9060508@mindcom.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F30156D.9060508@mindcom.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Antti Boman <antti.boman@mindcom.fi>
Cc: alsa-devel@lists.sourceforge.net, Paul Davis <paul@linuxaudiosystems.com>
List-Id: alsa-devel@alsa-project.org


On 05-Aug-2003 Antti Boman wrote:
> This seems like the problem I've always had with my single processor
> with JACK and SCHED_FIFO, with 2.4.20 kernel. I haven't tried the
> realtime setting for a while, though.
>
> Maybe there's some other thing causing these? Should we gather a bit
> more in-depth information on our computers?

I'm also having random Oopses and crashes. I use alsa0.9.6-stable,
linux 2.4.22p6-smp on a dual G4. I don't use Jack, it happens just
playing music with xmms, but it's rare enough I'm not sure it's caused
by ALSA or anything else. Yesterday I left my box in a endless kernel
compile cycle for many hours without ALSA running and I had no
problems. It also might be an hardware problem... I don't know. I
never had problems with nearly the same config on a single processor G3.



Bye.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
