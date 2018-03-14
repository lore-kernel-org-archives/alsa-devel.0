From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [GIT PULL]: kbl audio firmware update
Date: Wed, 14 Mar 2018 17:17:13 +0530
Message-ID: <20180314114713.GA22290@buildpc-HP-Z230>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B3222670BE
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 12:46:52 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-firmware@kernel.org
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Please PULL to receive the update for KBL audio DSP firmware.

The following changes since commit 9cf0ec08c8fa93ff3aa1cb5f16189735909c3ac6:

  Mellanox: Add new mlxsw_spectrum firmware 13.1620.192 (2018-03-12 09:59:13 -0400)

are available in the git repository at:

  https://github.com/sanyogrk/firmware.git kbl

for you to fetch changes up to 4c0bf113a55975d702673e57c5542f150807ad66:

  linux-firmware: intel: Update Kabylake audio firmware (2018-03-14 16:23:08 +0530)

----------------------------------------------------------------
Sanyog Kale (1):
      linux-firmware: intel: Update Kabylake audio firmware

 WHENCE                     |   4 +++-
 intel/dsp_fw_kbl.bin       |   2 +-
 intel/dsp_fw_kbl_v3420.bin | Bin 0 -> 243016 bytes
 3 files changed, 4 insertions(+), 2 deletions(-)
 create mode 100644 intel/dsp_fw_kbl_v3420.bin

Thanks,
Sanyog

-- 
