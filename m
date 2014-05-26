From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 2/2] ASoC: dapm: Add a helper to get the
 platform for DAPM kcontrol
Date: Mon, 26 May 2014 15:44:22 +0300
Message-ID: <53833726.9050007@linux.intel.com>
References: <1401106136-3745-1-git-send-email-vinod.koul@intel.com>
 <1401106136-3745-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2724A2650F7
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 14:44:34 +0200 (CEST)
In-Reply-To: <1401106136-3745-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
Cc: Kp Jeeja <jeeja.kp@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 05/26/2014 03:08 PM, Vinod Koul wrote:
> From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
>
> commit eee5d7f9 introduced helper for getting codec for DAPM kcontrol, for DSPs
> we need similar stuff for platforms as well
>
Please refer not only the commit id but also commit title ("ASoC: dapm: 
Add a helper to get the CODEC for DAPM kcontrol").

Makes commit log more clear and helps cases where original commit is 
backported to older tree.

-- 
Jarkko
