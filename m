From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH][DEPENDS-ON-DMA] ASoC: rsnd: SND_SOC_RCAR
 doesn't depend on DMA_OF
Date: Wed, 11 Nov 2015 14:41:18 +0530
Message-ID: <20151111091118.GK25173@localhost>
References: <87twoziq9j.wl%kuninori.morimoto.gx@renesas.com>
 <20151106094820.GU18409@sirena.org.uk>
 <87bnb4kqd5.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F9952605B1
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 10:07:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87bnb4kqd5.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 08, 2015 at 11:50:32PM +0000, Kuninori Morimoto wrote:
> Hi Mark, Vinod
> 
> > > This patch is based on DMA branch
> > > git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git :: topic/of
> > 
> > Is this going to Linus during the merge window?
> 
> I hope so, but I'm not sure Vinod's plan.
> 
> >> Vinod
> 
> Does your topic/of branch goes to Linus branch on this merge window ?
> I need this
> 9290a16cf19301224556bc7bcb913c0c2a45bb9a
> ("dmaengine: OF DMAEngine API based on CONFIG_DMA_OF instead of CONFIG_OF")

Yes it is merged to Linus's tree now

-- 
~Vinod
