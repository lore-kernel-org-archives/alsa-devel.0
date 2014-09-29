From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: add atmel ssc driver maintainer entry
Date: Mon, 29 Sep 2014 10:36:28 +0200
Message-ID: <54291A0C.3090206@atmel.com>
References: <1411869439-2719-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411869439-2719-1-git-send-email-voice.shen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 28/09/2014 03:57, Bo Shen :
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Sure:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks.

> ---
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3705430..c004e6f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1703,6 +1703,13 @@ M:	Nicolas Ferre <nicolas.ferre@atmel.com>
>  S:	Supported
>  F:	drivers/spi/spi-atmel.*
>  
> +ATMEL SSC DRIVER
> +M:	Bo Shen <voice.shen@atmel.com>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Supported
> +F:	drivers/misc/atmel-ssc.c
> +F:	include/linux/atmel-ssc.h
> +
>  ATMEL Timer Counter (TC) AND CLOCKSOURCE DRIVERS
>  M:	Nicolas Ferre <nicolas.ferre@atmel.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> 


-- 
Nicolas Ferre
