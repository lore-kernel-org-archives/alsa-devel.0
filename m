From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH 1/5] ASoC: au1x: Convert to
	devm_snd_soc_register_platform
Date: Sun, 30 Aug 2015 08:24:02 +0200
Message-ID: <CAOLZvyGYEgxoNsgRhm+3BXmUFBp7C91Mb_CiPGJjf_8ew7cJCg@mail.gmail.com>
References: <1440637769.18698.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
 [209.85.215.41])
 by alsa0.perex.cz (Postfix) with ESMTP id C952626074D
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 08:24:42 +0200 (CEST)
Received: by laboe4 with SMTP id oe4so28011656lab.0
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2015 23:24:42 -0700 (PDT)
In-Reply-To: <1440637769.18698.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 27, 2015 at 3:09 AM, Axel Lin <axel.lin@ingics.com> wrote:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/au1x/dbdma2.c | 11 ++---------
>  sound/soc/au1x/dma.c    | 11 ++---------
>  2 files changed, 4 insertions(+), 18 deletions(-)

Acked-by: Manuel Lauss <manuel.lauss@gmail.com>
