From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Revert "ASoC: SAMSUNG: Add I2S0
 internal dma driver"
Date: Thu, 11 Aug 2011 18:10:28 +0900
Message-ID: <1313053828.16663.1.camel@finisterre.wolfsonmicro.main>
References: <1311266209-14505-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<039f01cc4828$34618600$9d249200$@com>
	<20110722095407.GH23192@opensource.wolfsonmicro.com>
	<014501cc57ef$5ab76370$10262a50$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 40E9524383
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 11:10:43 +0200 (CEST)
In-Reply-To: <014501cc57ef$5ab76370$10262a50$%kim@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Sangbeom Kim' <sbkim73@samsung.com>, alsa-devel@alsa-project.org, 'Jassi Brar' <jassisinghbrar@gmail.com>, 'Liam Girdwood' <lrg@ti.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-08-11 at 15:24 +0900, Kukjin Kim wrote:

> So it's time to re-apply it in your tree and would be nice to me if you
> could make some branch for it so that I can merge it to test  with other
> Samsung stuff until being it in mainline.

I'm intending to do this at some point before -rc2.

> And is it possible to apply for v3.1? Because this should be in mainline
> v3.1 stable for working Samsung i2s.

Yes, obviously this is for 3.1.
