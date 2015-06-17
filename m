From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL] Braswell firmware update
Date: Wed, 17 Jun 2015 11:30:05 +0530
Message-ID: <20150617060005.GC28601@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 43B5F265A3E
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 07:58:47 +0200 (CEST)
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Linux firmware maintainers,

Please PULL to receive the updated BSW firmware binary which contains power
management fixes. We have also updated the version of binary in WHENCE file


The following changes since commit 3161bfa479d5e9ed4f46b57df9bcecbbc4f8eb3c:

  linux-firmware: Update firmware patch for Intel Bluetooth 7260 (B3/B4) (2015-05-13 11:12:48 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git BSW

for you to fetch changes up to e5fa14afd09909124fc7618fc4a0ac00fa4f9347:

  linux-firmware: update audio firmware for Braswell platform (2015-06-17 11:21:47 +0530)

----------------------------------------------------------------
Vinod Koul (1):
      linux-firmware: update audio firmware for Braswell platform

 WHENCE                |   1 +
 intel/fw_sst_22a8.bin | Bin 647390 -> 701614 bytes
 2 files changed, 1 insertion(+)

Thanks
-- 
~Vinod
