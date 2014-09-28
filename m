From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 2/2] MAINTAINERS: add atmel audio alsa driver maintainer entry
Date: Sun, 28 Sep 2014 09:57:19 +0800
Message-ID: <1411869439-2719-2-git-send-email-voice.shen@atmel.com>
References: <1411869439-2719-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411869439-2719-1-git-send-email-voice.shen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, nicolas.ferre@atmel.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c004e6f..30f92cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1665,6 +1665,12 @@ M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 S:	Supported
 F:	drivers/tty/serial/atmel_serial.c
 
+ATMEL Audio ALSA driver
+M:	Bo Shen <voice.shen@atmel.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Supported
+F:	sound/soc/atmel
+
 ATMEL DMA DRIVER
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.1.0.24.g4109c28
