From: "Tim Laszlo" <tim.laszlo@gmail.com>
Subject: Re: Creative Soundblaster X-Fi
Date: Fri, 29 Jun 2007 12:40:50 -0500
Message-ID: <5eebe2e60706291040t1a029b9dv14d6ef2bbbf7209c@mail.gmail.com>
References: <5eebe2e60706261223m358cdd56t539fa90bd5451a9a@mail.gmail.com>
	<87odizcwy5.wl%shinichiro@stained-g.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 78EEF24567
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jun 2007 19:40:53 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so435548nzf
	for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2007 10:40:52 -0700 (PDT)
In-Reply-To: <87odizcwy5.wl%shinichiro@stained-g.net>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shinichiro HIDA <shinichiro@stained-g.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

You made a much better choice then me... Your card should already be
supported.  The X-Fi Extreme Audio uses a known chipset.. sadly I picked up
the X-Fi XtremeMusic which does not.  You should be able to get your card
working.  Maybe you need an .asoundrc file?  Could your apps be playing to
the wrong card?

Timl

On 6/28/07, Shinichiro HIDA <shinichiro@stained-g.net> wrote:
>
> Hi,
>
> ;; Soryy for I am not a developer.. just a little info.
>
> >>>>> In <5eebe2e60706261223m358cdd56t539fa90bd5451a9a@mail.gmail.com>
> >>>>>   "Tim Laszlo" <tim.laszlo@gmail.com> wrote:
> > Has anyone worked on developing an open source driver for the sound
> blaster
> > x-fi cards?  I've been sitting on one for about a year (mental note
> check
> > support *before* buying..) and would love to use it already...  Creative
> has
> > promised drivers but they seem to be in no rush to support Linux.  I'd
> like
> > to try my hand at working on a driver for this, but without any
> technical
> > specs from creative I wouldn't really know where to begin.  Anyone have
> any
> > suggestions on how to start?  Anyone worked on this yet?  Am I nuts for
> even
> > considering this??
>
> heh heh.. I bought SB0790(X-Fi XtremeAudio PCI) last month. snd_ca0106
> driver attached to this card with alsa-driver-1.0.14, but I have no
> sound yet.
>
> ;; I do not have other OS on this machine, play only with Linux.
>
> I dumped some information with lspci, hwinfo etc.. at
>
> http://www.stained-g.net/wiki/shinichiro/index.php?Creative.X-Fi.XtremeAudio
>
> ;; Sorry for my wiki was frozen for blocking wiki-spams.
>
> --
>   Shinichiro HIDA  shinichiro@stained-g.net
>   GPG fingerprint = 5F2D 1656 FFF6 F691 A51C  5E61 E416 D398 470C 1CE9
>
>
