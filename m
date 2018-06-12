From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/8] ASoC: fsi: convert to SPDX identifiers
Date: Tue, 12 Jun 2018 08:06:22 -0300
Message-ID: <CAOMZO5DBLzhRE_ibhna5vOmVUD96FaXSpz-gfdZt5kU8AW=djA@mail.gmail.com>
References: <87po0wdda5.wl-kuninori.morimoto.gx@renesas.com>
 <87o9ggdd94.wl-kuninori.morimoto.gx@renesas.com>
 <CAOMZO5ACWxCandV_KhR7ysR0xoAxG8KO7qYCGA42Daq94ZGOxw@mail.gmail.com>
 <s5hlgbkzeae.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f195.google.com (mail-ot0-f195.google.com
 [74.125.82.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AC79267252
 for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2018 13:06:24 +0200 (CEST)
Received: by mail-ot0-f195.google.com with SMTP id w9-v6so22032305otj.7
 for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2018 04:06:24 -0700 (PDT)
In-Reply-To: <s5hlgbkzeae.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 12, 2018 at 3:53 AM, Takashi Iwai <tiwai@suse.de> wrote:

> ... is this really the consensus as the preferred style in the whole
> Linux kernel tree?  To be honest, I find it rather annoying.
>
> It's a food for bikeshed, and in general I'd postpone such changes
> unless we really have to convert.

Putting everything as // is Linus Torvalds' preferred style:
https://lkml.org/lkml/2017/11/25/133

Regards,

Fabio Estevam
