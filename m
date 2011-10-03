From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: samsung: s3c-i2s-v2.c needs module.h
Date: Mon, 3 Oct 2011 11:30:26 +0100
Message-ID: <20111003103026.GB23811@sirena.org.uk>
References: <1317562466.4996.2.camel@phoenix>
 <20111002182605.GC2857@opensource.wolfsonmicro.com>
 <CAF+7xWkfTJXwt1uUtXgkh5Go9yxWasdM5a3DuLnii_5LqB00UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAF+7xWkfTJXwt1uUtXgkh5Go9yxWasdM5a3DuLnii_5LqB00UQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 03, 2011 at 08:17:21AM +0800, Axel Lin wrote:
> 2011/10/3 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > What tree is this for? ?My primary development platform is based on this
> > driver, I'd expect to have noticed any build issues and I rather suspect
> > this isn't what you're supposed to do after all the module.h stuff has
> > settled down.

> I got the build error on linux-next (20110930).

That's exactly what I'm running at the minute with no problem...
