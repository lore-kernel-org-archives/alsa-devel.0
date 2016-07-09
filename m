From: Kyle McMartin <kyle@infradead.org>
Subject: Re: [GIT PULL] skylake audio firmware update
Date: Fri, 8 Jul 2016 21:08:01 -0400
Message-ID: <20160709010801.GF8680@merlin.infradead.org>
References: <20160707141011.GF12591@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 644FA2658CE
 for <alsa-devel@alsa-project.org>; Sat,  9 Jul 2016 03:08:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160707141011.GF12591@localhost>
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
Cc: alsa-devel@alsa-project.org, linux-firmware@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 07, 2016 at 07:40:11PM +0530, Vinod Koul wrote:
> Hello,
> 
> Please PULL to receive the updated audio firmware for SKL which contains
> update for supporting multiple languages.
> 
> The following changes since commit 3ef7857d511ce6a91c5ce609da76c4702651cfa5:
> 
>   amdgpu: update polaris ucode (2016-06-28 14:31:11 -0400)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git skl

pulled, thanks Vinod.

--Kyle

> 
> for you to fetch changes up to d4274de33ed9448e91b970225ce9afdb74d5f13e:
> 
>   linux-firmware: intel: Update Skylake audio firmware (2016-07-01 13:10:07 +0530)
> 
> ----------------------------------------------------------------
> Vinod Koul (1):
>       linux-firmware: intel: Update Skylake audio firmware
> 
>  WHENCE                        |   4 ++--
>  intel/dsp_fw_release.bin      |   2 +-
>  intel/dsp_fw_release_v951.bin | Bin 0 -> 221184 bytes
>  3 files changed, 3 insertions(+), 3 deletions(-)
>  create mode 100644 intel/dsp_fw_release_v951.bin
> 
> Thanks
> -- 
> ~Vinod
