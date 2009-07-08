From: "Ted T. Logan" <tedtheologian@gmail.com>
Subject: Re: Testers wanted: New SB X-Fi driver - still has
 clicks on sb0670
Date: Wed, 08 Jul 2009 13:59:51 -0500
Message-ID: <1247079591.7729.18.camel@localhost.localdomain>
References: <4812c8250907050138w586919d4vd23d71b4ae14e1dc@mail.gmail.com>
	<1247021134.3439.2.camel@localhost.localdomain>
	<s5hr5wr4szi.wl%tiwai@suse.de>  <s5hk52j4rom.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f217.google.com (mail-gx0-f217.google.com
	[209.85.217.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F1D224451
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jul 2009 20:59:15 +0200 (CEST)
Received: by gxk17 with SMTP id 17so3613399gxk.8
	for <alsa-devel@alsa-project.org>; Wed, 08 Jul 2009 11:59:14 -0700 (PDT)
In-Reply-To: <s5hk52j4rom.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It's never worked with your driver


only with this one:

 XFiDrv_Linux_Public_US_1.00.tar.gz


On Wed, 2009-07-08 at 08:25 +0200, Takashi Iwai wrote:

> At Wed, 08 Jul 2009 07:57:21 +0200,
> I wrote:
> > 
> > At Tue, 07 Jul 2009 21:45:34 -0500,
> > Ted T. Logan wrote:
> > > 
> > > The newest snapshot still has the same clicks with my xfi card, over and
> > > over and over and over and over and over
> > > 
> > > sb0670 chipset.
> > > 
> > > what to do?
> > 
> > Please bisect.
> 
> ... if it's difficult, give the date it worked (at best, show HEAD and 
> alsa-kernel/HEAD files included in the tarball) and it regressed.
> 
> 
> Takashi
