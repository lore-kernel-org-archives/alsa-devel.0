From: <Codrin.Ciubotariu@microchip.com>
Subject: Re: [PATCH 065/145] ASoC: atmel: mikroe-proto: use
 modern dai_link style
Date: Wed, 29 May 2019 15:24:26 +0000
Message-ID: <d7af4dec-a808-fc97-0f36-5c6b3aa4b2c4@microchip.com>
References: <87sgt7p3zo.wl-kuninori.morimoto.gx@renesas.com>
 <877eajmaij.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from esa5.microchip.iphmx.com (esa5.microchip.iphmx.com
 [216.71.150.166])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E097F806E5
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2019 17:24:31 +0200 (CEST)
In-Reply-To: <877eajmaij.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <6DAB9C92DA18E9438D4F537681A49F77@namprd11.prod.outlook.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: kuninori.morimoto.gx@renesas.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 22.05.2019 06:44, Kuninori Morimoto wrote:
> External E-Mail
> 
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> ASoC is now supporting modern style dai_link
> (= snd_soc_dai_link_component) for CPU/Codec/Platform.
> This patch switches to use it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Tested-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Thanks,
Codrin
