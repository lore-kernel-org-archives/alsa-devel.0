From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v2 3/4] Documentation: vendor-prefixes: Add option prefix
Date: Wed,  6 May 2015 22:38:49 +0200
Message-ID: <1430944730-10480-4-git-send-email-marek@goldelico.com>
References: <1430944730-10480-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430944730-10480-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de
Cc: broonie@kernel.org, hns@goldelico.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Marek Belisko <marek@goldelico.com>
List-Id: alsa-devel@alsa-project.org

Add option to vendor-prefixes file which will be used for Option NV company.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index b6682ab..ed3bd55 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -142,6 +142,7 @@ nvidia	NVIDIA
 nxp	NXP Semiconductors
 onnn	ON Semiconductor Corp.
 opencores	OpenCores.org
+option	Option NV
 ortustech	Ortus Technology Co., Ltd.
 ovti	OmniVision Technologies
 panasonic	Panasonic Corporation
-- 
1.9.1
