From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/5] ASoC: simple-card: convert to SPDX
	identifiers
Date: Tue, 3 Jul 2018 00:09:33 -0300
Message-ID: <CAOMZO5C=OmPv5jkqtVia702AU4q6wao3Fx4bTougex8mvPxKHA@mail.gmail.com>
References: <8736x2f93c.wl-kuninori.morimoto.gx@renesas.com>
 <871scmf929.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 420EA267731
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 05:09:35 +0200 (CEST)
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so901978oiw.8
 for <alsa-devel@alsa-project.org>; Mon, 02 Jul 2018 20:09:34 -0700 (PDT)
In-Reply-To: <871scmf929.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 2, 2018 at 3:30 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:

> index a6a2e15..d264e54 100644
> --- a/include/sound/simple_card.h
> +++ b/include/sound/simple_card.h
> @@ -1,12 +1,9 @@
> -/*
> +/* SPDX-License-Identifier: GPL-2.0

The first line should be:

/* SPDX-License-Identifier: GPL-2.0 */

as explained in Documentation/process/license-rules.rst
