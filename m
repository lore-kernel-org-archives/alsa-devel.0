From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/5 v2] ASoC: fsi: DMA support 1st step
Date: Sun, 19 Sep 2010 16:12:04 +0100
Message-ID: <20100919151204.GF18789@opensource.wolfsonmicro.com>
References: <w3p8w315641.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 85D92243E2
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Sep 2010 17:11:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3p8w315641.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 17, 2010 at 01:47:09PM +0900, Kuninori Morimoto wrote:
> 
> Dear Mark, Liam
> 
> These patches are v2 of 1st step for DMA support of FSI driver

> Kuninori Morimoto (5):
>       ASoC: fsi: Add fsi_dma_get_area
>       ASoC: fsi: modify noisy comment out
>       ASoC: fsi: Add fsi_dma_soft_push/pop function

Applied these three.

>       ASoC: fsi: modify variable name to easy to understand
>       ASoC: fsi: merge fsi_data_push/pop to fsi_fifo_data_ctrl

I've not yet reviewed these fully.
