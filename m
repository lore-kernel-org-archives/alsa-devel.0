From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/4] ASoC: SAMSUNG: Code clean-up suitable
 for current ASoC
Date: Mon, 10 Jan 2011 11:40:51 +0000
Message-ID: <20110110114051.GB23070@opensource.wolfsonmicro.com>
References: <1294375429-16729-1-git-send-email-sw.youn@samsung.com>
	<1294581682.4472.148.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D4EA103839
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 12:42:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294581682.4472.148.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, jassi.brar@samsung.com, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 09, 2011 at 02:01:22PM +0000, Liam Girdwood wrote:
> On Fri, 2011-01-07 at 13:43 +0900, Seungwhan Youn wrote:

> >  o [PATCH 1/4] ASoC: SAMSUNG: Remove AC97 header file
> >  o [PATCH 2/4] ASoC: SAMSUNG: Clean-up DMA header file
> >  o [PATCH 3/4] ASoC: SAMSUNG: Move PCM specific definitions into pcm.c
> >  o [PATCH 4/4] ASoC: SAMSUNG: Clean-up header includes

> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

I've applied 1-3, as discussed please do the updates Jassi requested to
patch 4.
