From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/5] compress: add compress data API to ALSA
	kernel
Date: Fri, 2 Sep 2011 12:30:56 +0100
Message-ID: <20110902113056.GA27415@opensource.wolfsonmicro.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EBD1E103813
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 13:30:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 02, 2011 at 11:36:20AM +0530, Vinod Koul wrote:
> As agreed during the ASoC workshop in May 2011, this set of patches are a
> proposal from Intel to add a new compressed data interface to ALSA. This
> proposal builds on the existing Intel solution and the experience gathered over
> two years with Meego and Android solutions. This proposal is no longer
> Intel-specific and was generalized with the addition of a basic core;
> codec-related definitions are based on the vendor-neutral OpenMAX AL standard. 

Excellent stuff, I'll have a look when I can.  Are there corresponding
patches to alsa-lib and alsa-utils?
