From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] ASOC: Atmel: ClassD: Simplify use of
 devm_ioremap_resource
Date: Mon, 4 Jul 2016 17:01:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1607041701120.3790@hadrien>
References: <20160704130352.GA16886@amitoj-Inspiron-3542> <20160704141533.GG6247@sirena.org.uk> <alpine.DEB.2.10.1607041651380.3790@hadrien> <20160704145959.GI6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160704145959.GI6247@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Amitoj Kaur Chawla <amitoj1606@gmail.com>, nicolas.ferre@atmel.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On Mon, 4 Jul 2016, Mark Brown wrote:

> On Mon, Jul 04, 2016 at 04:52:43PM +0200, Julia Lawall wrote:
> > On Mon, 4 Jul 2016, Mark Brown wrote:
>
> > > Please use subject lines matching the style for the subsystem.  This
> > > makes it easier for people to identify relevant patches.
>
> > The point is that ASOC should be ASoC?  Ther aren't many patches on this
> > file, and two of the three have the same subject line as the above, but
> > with ASoC rather than ASOC.
>
> Yes, that's the case here (this is one of my pre-canned responses and I
> didn't yet figure out a sensible way to make it parameterized yet,
> should add a bit about trawling git log though).

OK, thanks.  With all the capital letters it looks odd overall, so that is
why I was wondering.

julia
