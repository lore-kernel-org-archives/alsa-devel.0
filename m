From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv2 0/4] ASoC: multi-component - Samsung S3C
	Platform
Date: Sat, 17 Jul 2010 19:16:05 +0100
Message-ID: <1279390565.3070.9.camel@odin>
References: <1279260977-18342-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 473C410380D
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Jul 2010 20:16:08 +0200 (CEST)
Received: by wyf19 with SMTP id 19so3061358wyf.38
	for <alsa-devel@alsa-project.org>; Sat, 17 Jul 2010 11:16:08 -0700 (PDT)
In-Reply-To: <1279260977-18342-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <claude.youn@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-07-16 at 15:16 +0900, Seungwhan Youn wrote:
> Hi,
> 	
> This is a second version of patch series adding support for multi
> component model on Samsung S3C Platform.
> 
> This patch series can be apply upon "ASoC: multi-component - Fix S3C
> compile error" in the first patch of V1 that already applied by Liam.
> 
> Changes since V1:
> - Support for GPIO, DMA and SFR settings pull from platform device
>   resource.
> - Modify description of add WM9713 platform device on smdk board.
> 
> The following patch series contains:
> 
> [PATCHv2 1/4] ASoC: S3C64XX: Move GPIO settings to platform
> [PATCHv2 2/4] ASoC: S3C64XX: Move DMA settings to platform
> [PATCHv2 3/4] ASoC: multi-component - S3C - Get original functionality
> [PATCHv2 4/4] ASoC: multi-component - S3C - Add WM9713 platform device
> 

Thanks

All applied.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
