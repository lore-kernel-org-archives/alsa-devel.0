From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 1/2] dmaengine: add const for name parameter
Date: Thu, 21 Mar 2013 14:10:08 +0100
Message-ID: <20130321131008.GA7274@pengutronix.de>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <1363318601-31505-2-git-send-email-shawn.guo@linaro.org>
 <20130315085346.GA22650@pengutronix.de>
 <20130321094753.GN10326@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id D2580265E72
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 14:10:16 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Sebastien Guiriec <s-guiriec@ti.com>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Mar 21, 2013 at 03:17:53PM +0530, Vinod Koul wrote:
> On Fri, Mar 15, 2013 at 09:53:46AM +0100, Markus Pargmann wrote:
> > Hi,
> > 
> > I already sent a nearly identical patch:
> > https://patchwork.kernel.org/patch/2179321/
> I applied that one a while ago so Markus can you check my tree and see if
> anything is remaining, looks most of cases are covered

I looked in your slave-dma tree but can't find the patch there. The
names are not defined as constant in that tree.

Regards

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
