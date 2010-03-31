From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: [PATCH 0/4] pxa ssp patches
Date: Wed, 31 Mar 2010 08:50:37 -0400
Message-ID: <s2n771cded01003310550ydf506b14wfbd57f7f38fce176@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B35C2103812
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Mar 2010 14:50:38 +0200 (CEST)
Received: by pwj7 with SMTP id 7so39177pwj.38
	for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2010 05:50:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, al
List-Id: alsa-devel@alsa-project.org

These patches are based on ssp_cleanup of pxa git tree.

They're verified on pxa168 aspenite platform. Support I2S and Left J interface.
