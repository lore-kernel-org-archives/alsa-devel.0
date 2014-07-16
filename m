From: Brian Austin <brian.austin@cirrus.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: cs42xx8: Add SND_SOC_DAIFMT_DSP_A
 support
Date: Wed, 16 Jul 2014 09:38:20 -0500
Message-ID: <alpine.DEB.2.02.1407160937460.7394@heelrod>
References: <1405334371-4248-1-git-send-email-shengjiu.wang@freescale.com>
 <415792f55c1340179171516ba0c25242@BY2PR03MB332.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <415792f55c1340179171516ba0c25242@BY2PR03MB332.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "shengjiu.wang@freescale.com" <shengjiu.wang@freescale.com>
Cc: "brian.austin@cirrus.com" <brian.austin@cirrus.com>, "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 14 Jul 2014, shengjiu.wang@freescale.com wrote:

> Hi all
>
>    Sorry, add more maintainers.
>
> Best regards
> Wang shengjiu
>
> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Shengjiu Wang
> Sent: Monday, July 14, 2014 6:40 PM
> To: broonie@linaro.org
> Cc: alsa-devel@alsa-project.org
> Subject: [alsa-devel] [PATCH] ASoC: cs42xx8: Add SND_SOC_DAIFMT_DSP_A support
>
> According to the spec, the definition of TDM and ONELINE_24 for CS42XX8_INTF_DAC and CS42XX8_INTF_ADC is wrong. correct them and enable SND_SOC_DAIFMT_DSP_A support.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> ---
Acked-by: Brian Austin <brian.austin@cirrus.com>
