From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [RESEND PATCH v2 2/2] ASoC: samsung: drop support for legacy
 S3C24XX DMA API
Date: Tue, 10 Jun 2014 17:26:04 +0200
Message-ID: <5397238C.10004@samsung.com>
References: <1401642958-6236-1-git-send-email-anarsoul@gmail.com>
 <1401642958-6236-2-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1401642958-6236-2-git-send-email-anarsoul@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, Sangbeom Kim <sbkim73@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
List-Id: alsa-devel@alsa-project.org

Hi,

On 01.06.2014 19:15, Vasily Khoruzhick wrote:
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
> v2: No changes
> 
>  sound/soc/samsung/Kconfig  |   3 -
>  sound/soc/samsung/Makefile |   2 -
>  sound/soc/samsung/dma.c    | 460 ---------------------------------------------
>  3 files changed, 465 deletions(-)
>  delete mode 100644 sound/soc/samsung/dma.c
> 

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
