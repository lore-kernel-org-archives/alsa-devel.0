From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Thu, 02 Feb 2012 17:48:21 +0530
Message-ID: <1328185101.26182.16.camel@vkoul-udesk3>
References: <4f1f2489.c602440a.208e.ffff9d7bSMTPIN_ADDED@mx.google.com>
	<1327511249.11901.37.camel@odin>
	<1328087231.1610.28.camel@vkoul-udesk3>
	<CABS+qY2GADPO+wkmDf5hzT7uaH7v1zNrdAGKnLbip-QAL8V_RQ@mail.gmail.com>
	<1328181472.3974.5.camel@odin> <1328184200.26182.8.camel@vkoul-udesk3>
	<20120202120602.GB7428@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EF4E103C63
	for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2012 13:18:13 +0100 (CET)
In-Reply-To: <20120202120602.GB7428@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-02-02 at 12:06 +0000, Mark Brown wrote:
> On Thu, Feb 02, 2012 at 05:33:20PM +0530, Vinod Koul wrote:
> 
> > And Mark, can we see your wip changes??
> 
> No.  I essentially never have any WIP changes, anything I do to the
> point where it's actually useful gets submitted to mainline pretty much
> immediately.  I did do some stuff but it was too horrible as it was
> trying to figure out the hw_params automatically and this was causing
> appauling pain, underlying changes have bitrotted that away.
Okay thanks.

your thoughts on how this should be done?

-- 
~Vinod
