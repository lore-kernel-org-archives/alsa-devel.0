From: Kyle McMartin <kyle@infradead.org>
Subject: Re: [GIT PULL]: Skylake audio firmware update
Date: Mon, 20 Jun 2016 10:57:50 -0400
Message-ID: <20160620145750.GS9173@merlin.infradead.org>
References: <20160617083936.GF16910@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 07F6826545F
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 16:57:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160617083936.GF16910@localhost>
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

On Fri, Jun 17, 2016 at 02:09:36PM +0530, Vinod Koul wrote:
> Hi,
> 
> Please PULL to receive the latest Skylake audio firmware.
> 
> The following changes since commit a4bbc8112cc04fcc0e0861e8b72197b6cb83ab83:
> 
>   linux-firmware: Update firmware file for Intel Bluetooth 8260 (2016-06-09 08:11:22 -0400)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git skl
> 

Pulled, thanks Vinod.

--Kyle

> for you to fetch changes up to 80aae2270140807c4d8e304c39def1fe9f93edb9:
> 
>   linux-firmware: intel: Update Skylake audio firmware (2016-06-17 14:01:52 +0530)
> 
> ----------------------------------------------------------------
> Vinod Koul (1):
>       linux-firmware: intel: Update Skylake audio firmware
> 
>  WHENCE                        |   4 ++--
>  intel/dsp_fw_release.bin      |   2 +-
>  intel/dsp_fw_release_v948.bin | Bin 0 -> 221184 bytes
>  3 files changed, 3 insertions(+), 3 deletions(-)
>  create mode 100644 intel/dsp_fw_release_v948.bin
> 
> Thanks
> -- 
> ~Vinod
