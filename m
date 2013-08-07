From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: ad73311: Add to list of of Analog
	Devices supported CODECs
Date: Wed,  7 Aug 2013 18:01:53 +0100
Message-ID: <1375894913-8608-2-git-send-email-broonie@kernel.org>
References: <1375894913-8608-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C3C842617A6
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 19:02:00 +0200 (CEST)
In-Reply-To: <1375894913-8608-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 83f606f..8048c2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -595,6 +595,7 @@ S:	Supported
 F:	sound/soc/codecs/adau*
 F:	sound/soc/codecs/adav*
 F:	sound/soc/codecs/ad1*
+F:	sound/soc/codecs/ad7*
 F:	sound/soc/codecs/ssm*
 F:	sound/soc/codecs/sigmadsp.*
 
-- 
1.8.4.rc1
