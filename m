From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 6/6] compress: add makefile and kconfig file
Date: Wed, 23 Nov 2011 21:53:02 +0530
Message-ID: <1322065382.1516.318.camel@vkoul-udesk3>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-7-git-send-email-vinod.koul@linux.intel.com>
	<20111123160340.GE30049@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id A149B103B0C
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 17:26:38 +0100 (CET)
In-Reply-To: <20111123160340.GE30049@opensource.wolfsonmicro.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-11-23 at 16:03 +0000, Mark Brown wrote:
> On Tue, Nov 22, 2011 at 02:22:00PM +0530, Vinod Koul wrote:
> 
> >  sound/compress_offload/Kconfig  |   17 +++++++++++++++++
> >  sound/compress_offload/Makefile |    4 ++++
> 
> I'm surprised this is in a new directory rather than some new files in
> sound/core.
I wasn't sure, ok to change to sound/core.

-- 
~Vinod
