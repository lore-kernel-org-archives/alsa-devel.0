From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH 0/7] ASoC: ep93xx: convert to use
	snd_soc_register_card()
Date: Mon, 12 Sep 2011 18:59:21 +0300
Message-ID: <20110912155921.GA2657@mwesterb-mobl.ger.corp.intel.com>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
	<4E6D4100.7060007@gmail.com>
	<CABS+qY15T_fR4o4kxBYguXH64wzaCrypJZdaduDDht_9Vqokfg@mail.gmail.com>
	<20110912101939.GA2953@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DE80103807
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 17:59:29 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so1737941bkb.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2011 08:59:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110912101939.GA2953@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: hsweeten@visionengravers.com, alsa-devel@alsa-project.org, "Girdwood,
	Liam" <lrg@ti.com>, linux-arm-kernel@lists.infradead.org, Ryan Mallon <rmallon@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 12, 2011 at 11:19:39AM +0100, Mark Brown wrote:
> On Mon, Sep 12, 2011 at 05:55:49AM +0100, Girdwood, Liam wrote:
> 
> > ASoC parts
> 
> > Acked-by: Liam Girdwood <lrg@ti.com>
> 
> I'm happy with them too - they should probably all go in together,
> do folks want me to apply them to ASoC or should we merge via the ARM
> tree?

I'm kind of hoping that Hartley would (N)ACK the mach-ep93xx parts so that
they could be merged via ASoC tree.
