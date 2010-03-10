From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] mmp: enable sound in aspenite
Date: Wed, 10 Mar 2010 14:45:55 +0000
Message-ID: <20100310144555.GD24422@rakim.wolfsonmicro.main>
References: <771cded01003100516q6d02ad42qb992e03c5380803e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E011624456
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 15:45:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <771cded01003100516q6d02ad42qb992e03c5380803e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 10, 2010 at 08:16:23AM -0500, Haojian Zhuang wrote:
> From 2fbfce5a3cd1c17b4a8ea00bcc9c8be85fe9977a Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 10 Mar 2010 06:35:43 -0500
> Subject: [PATCH] [ARM] mmp: enable sound in aspenite
> 
> Enable sound on aspenite. Hifi mode is supported.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Again, might be best to merge this via ASoC as well as/instead of ARM.
