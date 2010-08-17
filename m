From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: [PATCH 0/3] ASoC: add 88pm860x codec driver and
	machine driver
Date: Tue, 17 Aug 2010 15:47:38 +0800
Message-ID: <AANLkTikXSipjpx51PGNz1SUf=FqtEVSeWONTRTt7dMtx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 99AFE24141
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Aug 2010 09:47:38 +0200 (CEST)
Received: by wwb39 with SMTP id 39so745248wwb.20
	for <alsa-devel@alsa-project.org>; Tue, 17 Aug 2010 00:47:38 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Functions:
1. append 88pm860x codec driver
2. add tavorevb3 machine driver
3. add saarb machine driver

Updates from v1 patches
1. Remove jack support. These will be append in later patches.
2. Remove EQ support. These will be append in later patches.
3. Update patches according to comments.

Thanks
Haojian
