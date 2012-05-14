From: "Reddy, M.R. Swami" <MR.Swami.Reddy@ti.com>
Subject: Re: [PATCH] ASoC: lm49453: Fix author e-mail address
Date: Mon, 14 May 2012 08:35:00 +0000
Message-ID: <354ACD19F280E44381F0C302BC7A15A38B5F@DLEE07.ent.ti.com>
References: <1336948264-4355-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 9255E104107
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 10:35:03 +0200 (CEST)
In-Reply-To: <1336948264-4355-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Girdwood, Liam" <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Thanks for lm49453 patches.

Thanks
Swami

-----Original Message-----
From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com] 
Sent: Monday, May 14, 2012 4:01 AM
To: Reddy, M.R. Swami; Girdwood, Liam
Cc: alsa-devel@alsa-project.org; Mark Brown
Subject: [PATCH] ASoC: lm49453: Fix author e-mail address

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/lm49453.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c index 02a8179..802b9f1 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -1546,5 +1546,5 @@ static struct i2c_driver lm49453_i2c_driver = {  module_i2c_driver(lm49453_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC LM49453 driver"); -MODULE_AUTHOR("M R Swami Reddy <MR.Swami.Reddy@ti.com");
+MODULE_AUTHOR("M R Swami Reddy <MR.Swami.Reddy@ti.com>");
 MODULE_LICENSE("GPL v2");
--
1.7.10
