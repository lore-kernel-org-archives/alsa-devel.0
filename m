From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] ASoC: Add adav* drivers to the Analog
	Devices file patterns
Date: Wed, 22 Jun 2011 23:09:56 +0200
Message-ID: <1308776997-12959-3-git-send-email-lars@metafoo.de>
References: <1308776997-12959-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-224.synserver.de
	[212.40.185.224]) by alsa0.perex.cz (Postfix) with SMTP id 04F13243EC
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 23:11:20 +0200 (CEST)
In-Reply-To: <1308776997-12959-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Mike Frysinger <vapier.adi@gmail.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 MAINTAINERS |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a26e9ec..4f7665c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -534,6 +534,7 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 W:	http://wiki.analog.com/
 S:	Supported
 F:	sound/soc/codecs/adau*
+F:	sound/soc/codecs/adav*
 F:	sound/soc/codecs/ad1*
 F:	sound/soc/codecs/ssm*
 
-- 
1.7.2.5
