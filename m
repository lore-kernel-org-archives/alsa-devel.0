From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] pxa: move ssp into plat
Date: Wed, 10 Mar 2010 14:25:54 +0000
Message-ID: <20100310142554.GA24422@rakim.wolfsonmicro.main>
References: <771cded01003100513k79133820j12c31f369309b0ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E36E12439C
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 15:25:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <771cded01003100513k79133820j12c31f369309b0ae@mail.gmail.com>
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

On Wed, Mar 10, 2010 at 08:13:56AM -0500, Haojian Zhuang wrote:
> From de71c00acab6e4ec61c3e151a54de4c2045a8e74 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 10 Mar 2010 06:26:09 -0500
> Subject: [PATCH] [ARM] pxa: move ssp into plat
> 
> Since ssp is shared between pxa and mmp, move ssp driver into plat directory.
> ---

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but you forgot your Signed-off-by.
