From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: duplicated test in sound/soc/codecs/sgtl5000.c
Date: Thu, 12 Jan 2012 22:37:43 -0800
Message-ID: <20120113063742.GA1013@opensource.wolfsonmicro.com>
References: <alpine.DEB.2.00.1201122210520.25187@pl-59034.rocq.inria.fr>
	<20120112222759.GA23716@opensource.wolfsonmicro.com>
	<7FE21149F4667147B645348EC605788508FBC9@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AF95C2434E
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 07:37:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7FE21149F4667147B645348EC605788508FBC9@039-SN2MPN1-013.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng-B29396 <B29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wolfram Sang <w.sang@pengutronix.de>, Julia Lawall <julia.lawall@lip6.fr>, "zengzm.kernel@gmail.com" <zengzm.kernel@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 13, 2012 at 06:21:00AM +0000, Dong Aisheng-B29396 wrote:

> Since zhaoming leaved Freescale a few month ago,
> would you mind if I send a patch to add my name under MODULE_AHTOER as
> Co-maintainer for this driver and update Zhaoming's email address?

Typically the way this ends up getting done is that the MODULE_AUTHOR is
left to bitrot but a MAINTAINERS file entry is added which reflects
who's actually working on the driver.  Comments also get added
sometimes.  But really I don't mind.
