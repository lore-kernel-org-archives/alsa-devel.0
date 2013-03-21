From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] dmaengine: add const for name parameter
Date: Thu, 21 Mar 2013 18:24:59 +0530
Message-ID: <20130321125459.GU10326@intel.com>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <1363318601-31505-2-git-send-email-shawn.guo@linaro.org>
 <20130315085346.GA22650@pengutronix.de>
 <20130321094753.GN10326@intel.com>
 <20130321131008.GA7274@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DF65265E97
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 14:20:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130321131008.GA7274@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Sebastien Guiriec <s-guiriec@ti.com>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 21, 2013 at 02:10:08PM +0100, Markus Pargmann wrote:
> Hi,
> 
> On Thu, Mar 21, 2013 at 03:17:53PM +0530, Vinod Koul wrote:
> > On Fri, Mar 15, 2013 at 09:53:46AM +0100, Markus Pargmann wrote:
> > > Hi,
> > > 
> > > I already sent a nearly identical patch:
> > > https://patchwork.kernel.org/patch/2179321/
> > I applied that one a while ago so Markus can you check my tree and see if
> > anything is remaining, looks most of cases are covered
> 
> I looked in your slave-dma tree but can't find the patch there. The
> names are not defined as constant in that tree.
Please check now, I had applied patches since morning but hadnt pushed out.
Pushed now...
> 
> Regards
> 
> Markus
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
