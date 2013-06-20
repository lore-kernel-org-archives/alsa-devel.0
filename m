From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v8 00/11] ASoC: fsl-ssi: ac97-slave support
Date: Thu, 20 Jun 2013 14:53:27 +0200
Message-ID: <20130620125327.GD3085@s25.your-server.de>
References: <1371389117-19729-1-git-send-email-mpa@pengutronix.de>
 <20130617023656.GE31687@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id A99572608EC
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2013 14:53:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130617023656.GE31687@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 17, 2013 at 10:36:57AM +0800, Shawn Guo wrote:
> On Sun, Jun 16, 2013 at 03:25:06PM +0200, Markus Pargmann wrote:
> > Markus Pargmann (11):
> >       ASoC: imx-pcm-dma: DT support
> >       ASoC: imx-pcm-fiq: Introduce pcm-fiq-params
> >       ASoC: fsl: Move soc_ac97_ops from imx-ssi to fsl_ssi
> >       ASoC: fsl-ssi: Add support for imx-pcm-fiq
> >       ASoC: fsl-ssi: Use generic DMA bindings if possible
> >       ASoC: fsl-ssi: imx ac97 support
> >       ARM: imx: Export ac97 reset functions
> >       ASoC: Add phycore-ac97-dt driver
> >       ASoC: fsl: Kconfig: Use fsl-ssi for phycore-ac97
> >       ASoC: fsl: Move fsl-ssi binding doc to sound/
> >       ASoC: fsl: Update fsl-ssi binding doc
> 
> Tested-by: Shawn Guo <shawn.guo@linaro.org>
> 
> 

Thank you for testing.

Regards,

Markus
