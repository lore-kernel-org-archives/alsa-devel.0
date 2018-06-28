From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: dpcm: extend channel merging to the backend cpu
 dai
Date: Thu, 28 Jun 2018 15:08:40 +0200
Message-ID: <1530191320.2900.109.camel@baylibre.com>
References: <20180627094818.5885-1-jbrunet@baylibre.com>
         <20180628101550.GC14040@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628101550.GC14040@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jiada Wang <jiada_wang@mentor.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2018-06-28 at 11:15 +0100, Mark Brown wrote:
> On Wed, Jun 27, 2018 at 11:48:18AM +0200, Jerome Brunet wrote:
> 
> >  As you've probably noticed, this patch applies on top Jiada's patch
> >  pf4c277b817cc ("ASoC: soc-pcm: DPCM cares BE channel constraint")
> 
> That isn't a valid hash...

Indeed :) Sorry about that, it was f4c277b817cc (drop the p)
