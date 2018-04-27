From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: [PATCH v2 0/2] ASoC: mt6797-mt6351: switch to SPDX
	license tag
Date: Fri, 27 Apr 2018 09:54:43 +0800
Message-ID: <20180427015445.4334-1-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 49EE5267862
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 03:54:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: garlic.tseng@mediatek.com, broonie@kernel.org, ryder.lee@mediatek.com
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org, chipeng.chang@mediatek.com, wsd_upstream@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

Author name correction is confirmed by Ryder and Garlic

change since v1:
c files header use c++ comment

KaiChieh Chuang (2):
  ASoC: mt6797: switch to SPDX license tag
  ASoC: mt6351 switch to SPDX license tag

 sound/soc/codecs/mt6351.c                          | 11 +++++------
 sound/soc/mediatek/mt6797/Makefile                 | 13 +------------
 sound/soc/mediatek/mt6797/mt6797-afe-clk.c         | 21 ++++++---------------
 sound/soc/mediatek/mt6797/mt6797-afe-clk.h         | 10 +---------
 sound/soc/mediatek/mt6797/mt6797-afe-common.h      | 10 +---------
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c         | 21 ++++++---------------
 sound/soc/mediatek/mt6797/mt6797-interconnection.h | 10 +---------
 sound/soc/mediatek/mt6797/mt6797-mt6351.c          | 21 ++++++---------------
 sound/soc/mediatek/mt6797/mt6797-reg.h             | 12 ++----------
 9 files changed, 29 insertions(+), 100 deletions(-)

-- 
2.12.5
