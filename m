From: Josh Boyer <jwboyer@kernel.org>
Subject: Re: [GIT PULL]: kbl audio firmware update
Date: Wed, 14 Mar 2018 08:03:13 -0400
Message-ID: <CA+5PVA6ZYYCoJp6R0UiSxT48JcsMJV=jTYoh_duDVx2hBR8N3Q@mail.gmail.com>
References: <20180314114713.GA22290@buildpc-HP-Z230>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 96F562670BE
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 13:10:09 +0100 (CET)
Received: from mail-qt0-f176.google.com (mail-qt0-f176.google.com
 [209.85.216.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DA19E2176E
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 12:03:14 +0000 (UTC)
Received: by mail-qt0-f176.google.com with SMTP id n12so3076552qtl.5
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 05:03:14 -0700 (PDT)
In-Reply-To: <20180314114713.GA22290@buildpc-HP-Z230>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: Patches Audio <patches.audio@intel.com>, alsa-devel@alsa-project.org, Linux Firmware <linux-firmware@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 14, 2018 at 7:47 AM, Sanyog Kale <sanyog.r.kale@intel.com> wrote:
> Hi,
>
> Please PULL to receive the update for KBL audio DSP firmware.
>
> The following changes since commit 9cf0ec08c8fa93ff3aa1cb5f16189735909c3ac6:
>
>   Mellanox: Add new mlxsw_spectrum firmware 13.1620.192 (2018-03-12 09:59:13 -0400)
>
> are available in the git repository at:
>
>   https://github.com/sanyogrk/firmware.git kbl
>
> for you to fetch changes up to 4c0bf113a55975d702673e57c5542f150807ad66:
>
>   linux-firmware: intel: Update Kabylake audio firmware (2018-03-14 16:23:08 +0530)
>
> ----------------------------------------------------------------
> Sanyog Kale (1):
>       linux-firmware: intel: Update Kabylake audio firmware
>
>  WHENCE                     |   4 +++-
>  intel/dsp_fw_kbl.bin       |   2 +-
>  intel/dsp_fw_kbl_v3420.bin | Bin 0 -> 243016 bytes
>  3 files changed, 4 insertions(+), 2 deletions(-)
>  create mode 100644 intel/dsp_fw_kbl_v3420.bin

Pulled and pushed out.  Thanks!

josh
