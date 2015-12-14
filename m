From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 08/13] ASoC: Intel: Skylake: Use
 CGCTL.MISCBDCGE for Phrase detection notification
Date: Mon, 14 Dec 2015 09:52:42 +0530
Message-ID: <20151214042242.GI1854@localhost>
References: <1449921993-21101-9-git-send-email-vinod.koul@intel.com>
 <201512130213.fd9SElQX%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E538260537
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2015 05:19:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201512130213.fd9SElQX%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <lkp@intel.com>
Cc: alsa-devel@alsa-project.org, "Dharageswari.R" <dharageswari.r@intel.com>, tiwai@suse.de, Jayachandran B <jayachandran.b@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 13, 2015 at 02:46:08AM +0800, kbuild test robot wrote:
> Hi Dharageswari.R,
> 
> [auto build test ERROR on asoc/for-next]
> [also build test ERROR on next-20151211]
> [cannot apply to v4.4-rc4]
> 
> url:    https://github.com/0day-ci/linux/commits/Vinod-Koul/ASoC-Intel-Skylake-Update-to-SKL-driver/20151212-201340
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> config: i386-allmodconfig (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "skl_enable_miscbdcge" undefined!

I will update this one, thanks for reporting

-- 
~Vinod
