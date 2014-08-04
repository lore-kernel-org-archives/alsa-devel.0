From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-ssi: Support for
	SND_SOC_DAIFMT_CBM_CFS
Date: Mon, 4 Aug 2014 12:27:27 -0300
Message-ID: <CAOMZO5D4OXxG346LZjGOCGjzoAZSz0N97XnWmUE09OYTDid-YQ@mail.gmail.com>
References: <1407164887-22703-1-git-send-email-fabio.falzoi84@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 by alsa0.perex.cz (Postfix) with ESMTP id E2A3826084B
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 17:27:27 +0200 (CEST)
Received: by mail-la0-f48.google.com with SMTP id gl10so5481095lab.21
 for <alsa-devel@alsa-project.org>; Mon, 04 Aug 2014 08:27:27 -0700 (PDT)
In-Reply-To: <1407164887-22703-1-git-send-email-fabio.falzoi84@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Falzoi <fabio.falzoi84@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, adamo.a60@gmail.com, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Markus Pargmann <mpa@pengutronix.de>, michael@amarulasolutions.com
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 4, 2014 at 12:08 PM, Fabio Falzoi <fabio.falzoi84@gmail.com> wrote:
> Add SND_SOC_DAIFMT_CBM_CFS support for Freescale architecture.
> Successfully tested on i.MX 6Quad Wandboard and UDOO boards connected to
> the pcm1792a codec.

Great, do you plan to submit the audio support into imx6q-udoo.dts?

Thanks
