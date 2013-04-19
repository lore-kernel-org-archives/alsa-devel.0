From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC 2/4] ASoC: imx-sgtl5000: Let the code clock
	be a mandatory binding
Date: Fri, 19 Apr 2013 00:54:22 -0300
Message-ID: <CAOMZO5BmUQvMfGymi4LuVqSDFwZRB4iPvntWCCqiLpDYLO7cDA@mail.gmail.com>
References: <1366242921-16376-1-git-send-email-festevam@gmail.com>
 <1366242921-16376-2-git-send-email-festevam@gmail.com>
 <20130418033616.GD20563@S2101-09.ap.freescale.net>
 <CAOMZO5CDBBV1H1-uj=qXj5Ayo_Lp57j6tcS7izN3AEGHze9XXg@mail.gmail.com>
 <20130418064106.GE20563@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f53.google.com (mail-vb0-f53.google.com
 [209.85.212.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 25AAC261654
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2013 05:54:24 +0200 (CEST)
Received: by mail-vb0-f53.google.com with SMTP id i3so3193873vbh.40
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 20:54:23 -0700 (PDT)
In-Reply-To: <20130418064106.GE20563@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, matt@genesi-usa.com, mfuzzey@gmail.com, broonie@kernel.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 18, 2013 at 3:41 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Though it's still under review, the patch [1] from Martin Fuzzey is just
> what you need.

Excellent, just applied Martin's patch and audio is functional on
mx51babbage now.

I will repost the series after Martin's patch gets applied.

Thanks,

Fabio Estevam
