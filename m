From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake - Add Skylake RT286
 I2S machine driver
Date: Mon, 12 Oct 2015 03:12:07 +0000
Message-ID: <1444619526.3544.6.camel@intel.com>
References: <201510101650.2oGqByd9%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AD5726170F
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 05:12:12 +0200 (CEST)
In-Reply-To: <201510101650.2oGqByd9%fengguang.wu@intel.com>
Content-Language: en-US
Content-ID: <A1793458F9FA8D4C8935899A9F36ABC6@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lkp <lkp@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "Abdullah,
 Omair M" <omair.m.abdullah@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "kbuild-all@01.org" <kbuild-all@01.org>, "Kp, Jeeja" <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2015-10-10 at 16:42 +0800, kbuild test robot wrote:
> Hi Omair,
> 
> [auto build test ERROR on next-20151009 -- if it's inappropriate base, please
> ignore]
> 
> config: arm-allmodconfig (attached as .config)
> reproduce:

That's nice, thanks. We should add a depends on X86 for this to not compile on non
X86 code

Will send updated patch

-- 
~Vinod
