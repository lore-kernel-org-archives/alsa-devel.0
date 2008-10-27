From: Josep Andreu <holborn@telefonica.net>
Subject: Re: 2.6.26.[6|7] vs. rt11 vs. alsa (usb) midi
Date: Mon, 27 Oct 2008 11:29:47 +0000
Message-ID: <20081027112947.ddc6681e.holborn@telefonica.net>
References: <1224989187.3706.7.camel@localhost.localdomain>
	<s5hljwazc9i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ctsmtpout4.frontal.correo (outmailhost.telefonica.net
	[213.4.149.242]) by alsa0.perex.cz (Postfix) with ESMTP id BEE1E24707
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 12:29:50 +0100 (CET)
Received: from p9.er.es (217.125.137.237) by ctsmtpout4.frontal.correo
	(7.2.056.6) id 4901A91200095550 for alsa-devel@alsa-project.org;
	Mon, 27 Oct 2008 12:29:50 +0100
In-Reply-To: <s5hljwazc9i.wl%tiwai@suse.de>
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


Hi

On Mon, 27 Oct 2008 09:13:29 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Sat, 25 Oct 2008 19:46:27 -0700,
> Fernando Lopez-Lezcano wrote:
> > 
> > Hi... anyone out there also having problem with this combination?
> >    2.6.26.7 or 2.6.26.6 with 2.6.26.6-rt11 and alsa MIDI
> > It looks to me like alsa midi is broken. 

> What about other MIDI devices on other bus, e.g. an MPU401 on a PCI
> soundcard or so?  There is a possibility of breakage in the USB driver
> side, too.

I have a lot of problems in kernel versions greater than 2.6.26.3-rt3, but I think is not ALSA related .... 

Josep
