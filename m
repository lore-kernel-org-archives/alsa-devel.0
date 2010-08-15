From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: fix pxa2xx-pcm.h path
Date: Sun, 15 Aug 2010 14:53:59 +0100
Message-ID: <20100815135359.GA27062@opensource.wolfsonmicro.com>
References: <AANLkTi=_BX_z68p3SGhr08K5JOmudaNRvZMVUAvSGfZV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3433124401
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Aug 2010 15:54:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=_BX_z68p3SGhr08K5JOmudaNRvZMVUAvSGfZV@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 13, 2010 at 09:55:27PM +0800, Haojian Zhuang wrote:
> From b761e3bb374e630011f22ce54963877310a0baca Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Fri, 13 Aug 2010 21:14:52 +0800
> Subject: [PATCH 2/5] ASoC: fix pxa2xx-pcm.h path
> 
> Since pxa2xx-pcm.h is removed from sound/soc/pxa, we need to update the
> path in related files.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Applied this and patch 3/5, thanks.
