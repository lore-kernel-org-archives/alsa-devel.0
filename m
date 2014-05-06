From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH v2 0/8] ASoC: Intel: rework the mfld
 platform driver
Date: Tue, 06 May 2014 15:40:02 +0100
Message-ID: <1399387202.2814.24.camel@loki>
References: <1399308565-14620-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 16C462619E6
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 16:40:13 +0200 (CEST)
In-Reply-To: <1399308565-14620-1-git-send-email-vinod.koul@intel.com>
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
Cc: jeeja.kp@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2014-05-05 at 22:19 +0530, Vinod Koul wrote:
> This patch series reworks and reformats the existing platform driver we use.
> This is stepping support for seconds series of patches which will support
> Merrifield platform with DPCM based implementation
> 
> Not much logical changes in code except adding drain support for compressed
> audio. Most is mere modularization of the existing code
> 
> Fixes in v2:
> - add two more patches
> - fix makefile addition is 4th patch
> - dropped name change in platform ops patch
> 

All

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
