From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Tue, 23 Feb 2010 16:43:03 +0800
Message-ID: <4f3252891002230043jac570eekde1164df62c75853@mail.gmail.com>
References: <20100216233825.GB23623@sirena.org.uk>
	<4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<20100218023742.GC23637@tango.0pointer.de>
	<4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
	<20100218181322.GB5606@tango.0pointer.de>
	<alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
	<4f3252891002190257u608073c3l48f2251d8a6458ee@mail.gmail.com>
	<20100219151328.GC25873@tango.0pointer.de>
	<4f3252891002201949k48e0208fw40590803ac1a8192@mail.gmail.com>
	<20100221193933.GA31800@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6524F103882
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 09:43:06 +0100 (CET)
Received: by pwi9 with SMTP id 9so3150340pwi.38
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 00:43:05 -0800 (PST)
In-Reply-To: <20100221193933.GA31800@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/2/22 Lennart Poettering <mznyfn@0pointer.de>

> On Sun, 21.02.10 11:49, Raymond Yau (superquad.vortex2@gmail.com) wrote:
>
> > The most common onboard audio is HDA so this is not any exceptional cases
> >
> > Those HDA multi streaming  feature are most users wanted in desktop
> > enviornment, are pulseaudio really designed for deskop or just only for
> > notebook and mobile ?
> >
> > The front panel green/pink jack can be used by one application while the
> > rear panel audio jacks can be used to another application for surround or
> > mic for karaoke
>
>
> >  Send a game's sound through 5.1 speakers while the Internet chatting
> audio
> > is sent through your headset.
>
> More often than not you'd probably use two seperate cards for that.
>

why do you need another sound card when you onboard audio HDA already
support this feature ?

e.g. Skype can use alsa hw device for better latency
l<http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>

>
