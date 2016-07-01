From: Kyle McMartin <kyle@infradead.org>
Subject: Re: [GIT PULL] Broxton fw update
Date: Fri, 1 Jul 2016 11:52:15 -0400
Message-ID: <20160701155215.GB8680@merlin.infradead.org>
References: <20160701041751.GS14945@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 685B82614FD
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2016 17:52:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160701041751.GS14945@localhost>
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
Cc: Patches Audio <patches.audio@intel.com>, alsa-devel@alsa-project.org, linux-firmware@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 01, 2016 at 09:47:52AM +0530, Vinod Koul wrote:
> 
> Please PULL to receive the latest Broxton fw.
> 
> The following changes since commit 3ef7857d511ce6a91c5ce609da76c4702651cfa5:
> 
>   amdgpu: update polaris ucode (2016-06-28 14:31:11 -0400)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git apl

Pulled and pushed. Thanks Vinod.

cheers,
--Kyle

> 
> for you to fetch changes up to 040c24514b94fcdbd6308d986d1bde59a704a21a:
> 
>   linux-firmware: intel: Update Broxton audio firmware (2016-06-29 14:20:20 +0530)
> 
> ----------------------------------------------------------------
> Vinod Koul (1):
>       linux-firmware: intel: Update Broxton audio firmware
> 
>  WHENCE                     |   4 ++--
>  intel/dsp_fw_bxtn.bin      |   2 +-
>  intel/dsp_fw_bxtn_v702.bin | Bin 0 -> 505608 bytes
>  3 files changed, 3 insertions(+), 3 deletions(-)
>  create mode 100644 intel/dsp_fw_bxtn_v702.bin
> 
> Thanks
> -- 
> ~Vinod
