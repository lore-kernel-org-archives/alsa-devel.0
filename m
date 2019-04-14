From: Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 0/2] Fix invalid license IDS
Date: Sun, 14 Apr 2019 22:14:48 +0300
Message-ID: <20190414191450.18377-1-andradanciu1997@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, daniel.baluta@gmail.com
List-Id: alsa-devel@alsa-project.org

This series of patches solves two issues reported by Thomas Gleixner

Andra Danciu (2):
  ASoC: mpc5200_dma: Fix invalid license ID
  ASoC: mpc5200_psc_i2s: Fix invalid license ID

 sound/soc/fsl/mpc5200_dma.c     | 2 +-
 sound/soc/fsl/mpc5200_psc_i2s.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.11.0
