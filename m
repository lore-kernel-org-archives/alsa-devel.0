From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 0056/1529] Fix typo
Date: Sat, 21 May 2016 13:44:21 +0200
Message-ID: <20160521114421.1953-1-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, corbet@lwn.net, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/sound/alsa/soc/machine.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sound/alsa/soc/machine.txt b/Documentation/sound/alsa/soc/machine.txt
index 74056db..6bf2d20 100644
--- a/Documentation/sound/alsa/soc/machine.txt
+++ b/Documentation/sound/alsa/soc/machine.txt
@@ -3,7 +3,7 @@ ASoC Machine Driver
 
 The ASoC machine (or board) driver is the code that glues together all the
 component drivers (e.g. codecs, platforms and DAIs). It also describes the
-relationships between each componnent which include audio paths, GPIOs,
+relationships between each component which include audio paths, GPIOs,
 interrupts, clocking, jacks and voltage regulators.
 
 The machine driver can contain codec and platform specific code. It registers
-- 
2.8.2.534.g1f66975

