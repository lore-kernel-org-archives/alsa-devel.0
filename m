From: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andreas.irestal@axis.com>
Subject: [PATCH v2 2/5] ASoC: adau17x1: Correct typos in file headers
Date: Tue, 16 Feb 2016 13:56:42 +0100
Message-ID: <1455627405-18155-3-git-send-email-andire@axis.com>
References: <1455627405-18155-1-git-send-email-andire@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455627405-18155-1-git-send-email-andire@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Andreas=20Irest=C3=A5l?= <andire@axis.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Andreas Irest=C3=A5l <andire@axis.com>
---
 include/linux/platform_data/adau17x1.h | 2 +-
 sound/soc/codecs/adau1761-i2c.c        | 2 +-
 sound/soc/codecs/adau1761-spi.c        | 2 +-
 sound/soc/codecs/adau1761.c            | 2 +-
 sound/soc/codecs/adau1781.c            | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/platform_data/adau17x1.h b/include/linux/pla=
tform_data/adau17x1.h
index a81766c..9db1b90 100644
--- a/include/linux/platform_data/adau17x1.h
+++ b/include/linux/platform_data/adau17x1.h
@@ -1,5 +1,5 @@
 /*
- * Driver for ADAU1761/ADAU1461/ADAU1761/ADAU1961/ADAU1781/ADAU1781 co=
decs
+ * Driver for ADAU1361/ADAU1461/ADAU1761/ADAU1961/ADAU1381/ADAU1781 co=
decs
  *
  * Copyright 2011-2014 Analog Devices Inc.
  * Author: Lars-Peter Clausen <lars@metafoo.de>
diff --git a/sound/soc/codecs/adau1761-i2c.c b/sound/soc/codecs/adau176=
1-i2c.c
index 348ccb1..a1b1267 100644
--- a/sound/soc/codecs/adau1761-i2c.c
+++ b/sound/soc/codecs/adau1761-i2c.c
@@ -1,5 +1,5 @@
 /*
- * Driver for ADAU1761/ADAU1461/ADAU1761/ADAU1961 codec
+ * Driver for ADAU1361/ADAU1461/ADAU1761/ADAU1961 codec
  *
  * Copyright 2014 Analog Devices Inc.
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
diff --git a/sound/soc/codecs/adau1761-spi.c b/sound/soc/codecs/adau176=
1-spi.c
index 8bc1fbd..1883349 100644
--- a/sound/soc/codecs/adau1761-spi.c
+++ b/sound/soc/codecs/adau1761-spi.c
@@ -1,5 +1,5 @@
 /*
- * Driver for ADAU1761/ADAU1461/ADAU1761/ADAU1961 codec
+ * Driver for ADAU1361/ADAU1461/ADAU1761/ADAU1961 codec
  *
  * Copyright 2014 Analog Devices Inc.
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index 2f12477..16fed36 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -1,5 +1,5 @@
 /*
- * Driver for ADAU1761/ADAU1461/ADAU1761/ADAU1961 codec
+ * Driver for ADAU1361/ADAU1461/ADAU1761/ADAU1961 codec
  *
  * Copyright 2011-2013 Analog Devices Inc.
  * Author: Lars-Peter Clausen <lars@metafoo.de>
diff --git a/sound/soc/codecs/adau1781.c b/sound/soc/codecs/adau1781.c
index fde9068..bc1bb56 100644
--- a/sound/soc/codecs/adau1781.c
+++ b/sound/soc/codecs/adau1781.c
@@ -1,5 +1,5 @@
 /*
- * Driver for ADAU1781/ADAU1781 codec
+ * Driver for ADAU1381/ADAU1781 codec
  *
  * Copyright 2011-2013 Analog Devices Inc.
  * Author: Lars-Peter Clausen <lars@metafoo.de>
--=20
2.1.4
