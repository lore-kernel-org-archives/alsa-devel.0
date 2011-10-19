From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: sgtl5000: Fix define for
	SGTL5000_BIAS_R_MASK
Date: Wed, 19 Oct 2011 13:09:01 +0100
Message-ID: <20111019120901.GD3107@opensource.wolfsonmicro.com>
References: <1318992896.7128.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3C2B224367
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 14:09:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318992896.7128.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Zeng Zhaoming <zhaoming.zeng@freescale.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 19, 2011 at 10:54:56AM +0800, Axel Lin wrote:
> According to the datasheet:
> CHIP_MIC_CTRL 0x002A

Applied both, thanks.
