From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 0/4] Add ESAI & SPDIF Vybird and LS1+ support.
Date: Thu, 3 Apr 2014 17:10:53 +0800
Message-ID: <1396516257-25354-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 by alsa0.perex.cz (Postfix) with ESMTP id F091D2656A1
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 11:54:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, timur@tabi.org, Guangyu.Chen@freescale.com
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org


Xiubo Li (4):
  ASoC: esai: fix buggy of 'ret' type definition.
  ASoC: esai: Add Vybird and LS1+ compatibles support.
  ASoC: spdif: Sort the header files alphabetically.
  ASoC: spdif: Add Vybird and LS1+ compatibles support.

 sound/soc/fsl/fsl_esai.c  | 10 +++++++---
 sound/soc/fsl/fsl_spdif.c | 10 ++++++----
 2 files changed, 13 insertions(+), 7 deletions(-)

-- 
1.8.4
