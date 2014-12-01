From: Kyle McMartin <kyle@infradead.org>
Subject: Re: [GIT PULL] Add sst audio firmware for baytrail
	platforms
Date: Sun, 30 Nov 2014 21:11:58 -0500
Message-ID: <20141201021158.GD2930@merlin.infradead.org>
References: <20141110093358.GD18555@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E6D926056F
 for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2014 03:12:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141110093358.GD18555@intel.com>
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

On Mon, Nov 10, 2014 at 03:03:58PM +0530, Vinod Koul wrote:
> Hello Linux firmware maintainers,
> 
> Please PULL to receive the Intel audio firmware for audio DSP in Baytrail
> platforms. This firmware is using the same license as another version of
> the Baytrail firmware already available in linux-firmware git.
> 
> The following changes since commit 0e5f63771d0df6d7859f7c4100a74d737c62ac88:
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git byt
> 
> Vinod Koul (1):
>       linux-firmware: add sst audio firmware for baytrail platforms
> 
>  WHENCE                |    8 ++++++++
>  intel/fw_sst_0f28.bin |  Bin 0 -> 647078 bytes
>  2 files changed, 8 insertions(+), 0 deletions(-)
>  create mode 100644 intel/fw_sst_0f28.bin
> 

applied, thanks very much vinod.
