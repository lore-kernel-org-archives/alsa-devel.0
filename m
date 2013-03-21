From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] dmaengine: add const for name parameter
Date: Thu, 21 Mar 2013 22:57:30 +0800
Message-ID: <20130321145728.GD23109@S2101-09.ap.freescale.net>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <1363318601-31505-2-git-send-email-shawn.guo@linaro.org>
 <20130315085346.GA22650@pengutronix.de>
 <20130321094753.GN10326@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 by alsa0.perex.cz (Postfix) with ESMTP id AE6E0265121
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 15:57:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130321094753.GN10326@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sebastien Guiriec <s-guiriec@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Vinod,

On Thu, Mar 21, 2013 at 03:17:53PM +0530, Vinod Koul wrote:
> On Fri, Mar 15, 2013 at 09:53:46AM +0100, Markus Pargmann wrote:
> > Hi,
> > 
> > I already sent a nearly identical patch:
> > https://patchwork.kernel.org/patch/2179321/
> I applied that one a while ago so Markus can you check my tree and see if
> anything is remaining, looks most of cases are covered
> 
Can you maintain that patch on a topic branch, so that we can ask Mark
to pull it as dependency for the soc-dmaengine-pcm patch that support
generic DMA binding users?

Shawn
