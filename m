From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: ARM in embedded audio
Date: Mon, 25 Jun 2007 21:23:31 +0530
Message-ID: <8d6898730706250853r25e61e31jf91660c2fbeec8a1@mail.gmail.com>
References: <200706222325.43188.gineera@aspect135.co.uk>
	<8d6898730706222149p3e7ca214ndf00acd697ed16d4@mail.gmail.com>
	<200706251626.38760.gineera@aspect135.co.uk>
	<1182784591.26658.290.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by alsa0.perex.cz (Postfix) with ESMTP id EAE3324333
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2007 17:53:33 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so1870278wag
	for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2007 08:53:32 -0700 (PDT)
In-Reply-To: <1182784591.26658.290.camel@localhost.localdomain>
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
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

We are using ARM platform, it has both ac97 and i2S controllers.
This is still on final phase of development
we are using wolfson and TI codecs

On 6/25/07, Liam Girdwood <lg@opensource.wolfsonmicro.com> wrote:
> On Mon, 2007-06-25 at 16:26 +0100, Alan Horstmann wrote:
> > On Saturday 23 June 2007 05:49, you wrote:
> > > This will be almost same as Desktop PCs, only thing is you will have
> > > to cross compile.
> > >
> > > Which chipset you are using? which codec?
> >
> > That is not decided yet -hence my enquiry.  We are trying to estimate how hard
> > or straightforward it wil be to get a low-cost platform up and running.  But
> > we will need I2S.
> >
>
> Fwiw, currently supported codecs and platforms under ASoC :-
>
> http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=tree;f=sound/soc;h=232b0ff3ccc8a37861c077618d18a9755376133d;hb=dev
>
> Sorry, can't advise any further as I'm biased.
>
> Liam
>
>
