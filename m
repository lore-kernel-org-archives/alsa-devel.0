From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH 01/20] ASoC: imx-pcm: Switch to SPDX identifier
Date: Fri, 5 Apr 2019 17:40:32 +0530
Message-ID: <200227b8-5e03-4676-7371-92a3641fde3e@codeaurora.org>
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
 <20190405115010.28838-2-andradanciu1997@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405115010.28838-2-andradanciu1997@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andra Danciu <andradanciu1997@gmail.com>, timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: daniel.baluta@nxp.com
List-Id: alsa-devel@alsa-project.org


On 4/5/2019 5:19 PM, Andra Danciu wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>
> Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   sound/soc/fsl/imx-pcm.h | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
> index 133c4470acad..5dd406774d3e 100644
> --- a/sound/soc/fsl/imx-pcm.h
> +++ b/sound/soc/fsl/imx-pcm.h
> @@ -1,13 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
>   /*
>    * Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
>    *
>    * This code is based on code copyrighted by Freescale,
>    * Liam Girdwood, Javier Martin and probably others.
> - *
> - * This program is free software; you can redistribute  it and/or modify it
> - * under  the terms of  the GNU General  Public License as published by the
> - * Free Software Foundation;  either version 2 of the  License, or (at your
> - * option) any later version.
>    */
>   
>   #ifndef _IMX_PCM_H
