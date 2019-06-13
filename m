From: "Lai, Poey Seng" <poey.seng.lai@intel.com>
Subject: [PATCH] ALSA: hda: Add Elkhart Lake PCI ID
Date: Fri, 14 Jun 2019 00:21:38 +0800
Message-ID: <1560442899-11169-1-git-send-email-poey.seng.lai@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67288F80794
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 10:16:51 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,
This is to add Elkhart lake PCI ID
in order to support Elkhart Lake SoC.

Lai, Poey Seng (1):
  ALSA: hda: Add Elkhart Lake PCI ID

 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.7.4
