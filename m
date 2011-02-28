From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: remove unnecessary header including
 in SGTL5000 codec driver
Date: Mon, 28 Feb 2011 14:33:44 +0000
Message-ID: <20110228143344.GA13869@opensource.wolfsonmicro.com>
References: <1298835921-16428-1-git-send-email-zhaoming.zeng@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B61A103891
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 15:33:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1298835921-16428-1-git-send-email-zhaoming.zeng@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: zhaoming.zeng@freescale.com
Cc: alsa-devel@alsa-project.org, Zeng Zhaoming <b32542@freescale.com>, s.hauer@pengutronix.de, timur.tabi@gmail.com, zengzm.kernel@gmail.com, arnaud.patard@rtp-net.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 28, 2011 at 03:45:21AM +0800, zhaoming.zeng@freescale.com wrote:
> From: Zeng Zhaoming <b32542@freescale.com>
> 
> Remove unnecessary headers:
>  - mach/hardware.h in sgtl5000.c
>  - linux/i2c.h in sgtl5000.h

Applied, thanks.
