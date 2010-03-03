From: jassi brar <jassisinghbrar@gmail.com>
Subject: ASoC: SAMSUNG: About I2S_v4 support
Date: Wed, 3 Mar 2010 17:32:13 +0900
Message-ID: <1b68c6791003030032n7de8a0d8t5395a0a260d92b19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DFAF1038AF
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 09:32:14 +0100 (CET)
Received: by vws15 with SMTP id 15so439192vws.38
	for <alsa-devel@alsa-project.org>; Wed, 03 Mar 2010 00:32:13 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Ben Dooks <ben-linux@fluff.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello,

Could we please reach some agreement about the support of I2Sv4 block of
S3C64XX and newer SoCs?
Kindly express your opinion.

Otherwise, I am planning to re-factor(as and if needed) s3c-i2s-v2.c,
s3c2412-i2s.c and s3c64xx-i2s.c
and add a new s3c-i2s-v4.c to handle I2S_v4 controllers.
Kindly ACK/NAK this idea if you are busy with other stuff and I am to
start working on the issue.

Thanks.
