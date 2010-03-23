From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/3] ASoC: ak4642: Add set_fmt function for
 snd_soc_dai_ops
Date: Tue, 23 Mar 2010 15:36:54 +0000
Message-ID: <1269358614.3754.51.camel@odin>
References: <uvdcn4hx0.wl%morimoto.kuninori@renesas.com>
	<usk7r4hwa.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.216.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 545BB103873
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2010 16:36:55 +0100 (CET)
Received: by pxi7 with SMTP id 7so2719974pxi.5
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2010 08:36:53 -0700 (PDT)
In-Reply-To: <usk7r4hwa.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-03-15 at 18:10 +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  sound/soc/codecs/ak4642.c |   69 +++++++++++++++++++++++++++++---------------
>  sound/soc/sh/fsi-ak4642.c |    4 ++
>  2 files changed, 49 insertions(+), 24 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
