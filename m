From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH v4 0/4] ASoC: Intel: clean up Kconfig
Date: Wed, 11 Jan 2017 08:12:08 +0000
Message-ID: <1484122328.2604.20.camel@loki>
References: <20170107123250.52930-1-andriy.shevchenko@linux.intel.com>
 <20170110090408.GD3573@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 543C7266639
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2017 09:12:13 +0100 (CET)
In-Reply-To: <20170110090408.GD3573@localhost>
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
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2017-01-10 at 14:34 +0530, Vinod Koul wrote:
> On Sat, Jan 07, 2017 at 02:32:46PM +0200, Andy Shevchenko wrote:
> > Clean up Kconfig here:
> > - select DW_DMAC_CORE because it's mandatory for some modules
> > - remove redundant selects and dependencies
> > - rename MFLD_PLATFORM to ATOM_HIFI2_PLATFORM to show that it covers more than *Field
> 
> Looks good to me,
> 
> Acked-by: Vinod Koul <vinod.koul@intel.com>
> 
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>


---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
