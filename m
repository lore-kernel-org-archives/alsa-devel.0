From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: rt5640: Add minimal support for
	RT5642
Date: Tue, 22 Apr 2014 09:01:24 +0300
Message-ID: <535605B4.3090009@linux.intel.com>
References: <1397701446-11977-1-git-send-email-bardliao@realtek.com>
 <20140417190129.GH12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 40F70261A50
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 08:01:56 +0200 (CEST)
In-Reply-To: <20140417190129.GH12304@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 04/17/2014 10:01 PM, Mark Brown wrote:
> On Thu, Apr 17, 2014 at 10:24:06AM +0800, bardliao@realtek.com wrote:
>
>> From: Bard Liao <bardliao@realtek.com>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> Signed-off-by: Bard Liao <bardliao@realtek.com>
> Jarkko, are you OK with this (and the change in general)?
Yes, it's effectively same as my patch with Bard's actual device ID bits 
description in reset register.

-- 
Jarkko
