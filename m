From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: use a helper macro
 to rounding-up calculation
Date: Wed, 8 Mar 2017 13:16:51 +0530
Message-ID: <20170308074651.GK2843@localhost>
References: <20170306071222.16219-1-takashi.sakamoto@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 67D67266FF6
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 08:45:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170306071222.16219-1-takashi.sakamoto@miraclelinux.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
Cc: alsa-devel@alsa-project.org, ichiro.suzuki@miraclelinux.com, Takashi Sakamoto <o-takashi@sakamocchi.jp>, broonie@kernel.org, shreyas.nc@intel.com, jeeja.kp@intel.com, yukie.kato@miraclelinux.com
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 06, 2017 at 04:12:22PM +0900, Takashi Sakamoto wrote:
> In 'include/linux/kernel.h', there's a helper macro to round numerical
> value. Let's use it.
> 
> Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Signed-off-by: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>

Thanks Takashi-San for this.

Acked-by: Vinod Koul <vinod.koul@intel.com>
Tested-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

-- 
~Vinod
