From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Can someone verify support for
Date: Wed, 23 May 2007 20:03:58 +0000 (UTC)
Message-ID: <loom.20070523T215013-179@post.gmane.org>
References: <20070513101757.8C8191BF23B@ws1-1.us4.outblaze.com>
	<4648DA4E.8050107@gmail.com> <4648E10B.4010403@gmail.com>
	<20070515101259.GS5690@sygehus.dk> <464B955F.3030508@gmail.com>
	<20070517130811.GY5690@sygehus.dk> <464E6710.4000909@gmail.com>
	<20070520122349.GB5690@sygehus.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D2B52467A
	for <alsa-devel@alsa-project.org>;
	Wed, 23 May 2007 22:15:40 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HqxEc-0007Ta-Jf
	for alsa-devel@alsa-project.org; Wed, 23 May 2007 22:15:03 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 23 May 2007 22:15:02 +0200
Received: from rene.herman by cc334381-b.groni1.gr.home.nl with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 23 May 2007 22:15:02 +0200
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

Rask Ingemann Lambertsen <rask <at> sygehus.dk> writes:

> > If J1 and J2 are connected to pin 17 and 18 at the top (the side which is 
> > "up" when you can read the markings) of the AZTSSPT0592 then those will be 
> > my J4/J5. Also unmarked, but I have the booklet!
> 
>    They are. I also have J4/J5 labelled PC SPKR, do you happen to know what
> they are for?

I seem to have misplaced this message; am replying through gmane hoping it will
keep the thread intact...

Those will be my J1/J2. Mine are next to the CD-ROM audio connector (and next to
a waveblaster header).

My J2 is the one actually labeled "PC SPK" and is not a jumper but a two pin
connector; with my NX Pro 16 comes a one-wire cable with a 4-pin connector that
you plug onto the motherboard speaker-out connector and a 2-pin connector that
you stick on J2, after which the soundcard fills the role of the PC speaker.

J1 is the "speaker amplification jumper". To quote the manual: 

"PCs from various manufacturers may have different internal PC speaker loudness.
Thus, the function of the Speaker Amplification Jumper (J1) is to compensate for
this differing internal PC speaker loudness among PCs."

Open is low amplification, closed is high.

(my Nx Pro 16 by the way also has an additional 4-pin "PHONE1" connector that
can be used to again attach the PC speaker to)

Rene.
