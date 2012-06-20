From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v2 1/3] dmaengine: Add wrapper for
 device_tx_status callback
Date: Wed, 20 Jun 2012 19:07:45 +0530
Message-ID: <1340199465.1927.1658.camel@vkoul-udesk3>
References: <1339438302-12417-1-git-send-email-lars@metafoo.de>
	<1340189662.1927.1648.camel@vkoul-udesk3> <4FE1BE79.5080903@metafoo.de>
	<20120620130958.GN3978@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 28C9C245BE
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2012 15:45:33 +0200 (CEST)
In-Reply-To: <20120620130958.GN3978@opensource.wolfsonmicro.com>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, Mika Westerberg <mika.westerberg@iki.fi>, linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-06-20 at 14:09 +0100, Mark Brown wrote:
> On Wed, Jun 20, 2012 at 02:13:45PM +0200, Lars-Peter Clausen wrote:
> 
> > There is a compile time dependency between the patches, so this patch should
> > go through the ASoC tree as well, or we'll have to wait another release
> > before the ASoC patches can be applied.
> 
> Yes, I was just going to say that - are you OK with me applying these
> Vinod?

Ah spoke too soon.

Please go ahead :)

-- 
~Vinod
