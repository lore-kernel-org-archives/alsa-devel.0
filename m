From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl-asoc-card: add wm8960 support
Date: Tue, 5 Apr 2016 14:38:48 -0300
Message-ID: <CAOMZO5DDZkZUeyhgGzxN7dGoY+fnUA+zUb23q_6gX05JLQw3hA@mail.gmail.com>
References: <d873df2b23a6d39099b3c62db8901d78a60d9362.1439550574.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f172.google.com (mail-ig0-f172.google.com
 [209.85.213.172])
 by alsa0.perex.cz (Postfix) with ESMTP id BE37D2654BA
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2016 19:38:49 +0200 (CEST)
Received: by mail-ig0-f172.google.com with SMTP id f1so111963640igr.1
 for <alsa-devel@alsa-project.org>; Tue, 05 Apr 2016 10:38:49 -0700 (PDT)
In-Reply-To: <d873df2b23a6d39099b3c62db8901d78a60d9362.1439550574.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Zidan,

On Fri, Aug 14, 2015 at 8:11 AM, Zidan Wang <zidan.wang@freescale.com> wrote:
> add wm8960 support for fsl-asoc-card
>
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>

Have you managed to get fsl-asoc-card to work with wm8960 on a imx7d-sdb board?

I am trying to do this now, but after running 'aplay file.wav' I get
no sound and the prompt never comes back.
