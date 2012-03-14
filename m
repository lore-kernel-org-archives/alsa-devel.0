From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 11/16] ARM: ux500: Add placeholder for
	clk_set_parent
Date: Wed, 14 Mar 2012 11:43:22 +0100
Message-ID: <CACRpkdb1HCuMj7G3v63URxPJBKqHf=cVHAw+7NEQ23G4ex4AoQ@mail.gmail.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-12-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A28C1044A8
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 11:43:22 +0100 (CET)
Received: by ggni2 with SMTP id i2so1665080ggn.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 03:43:22 -0700 (PDT)
In-Reply-To: <1331651503-16917-12-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 13, 2012 at 4:11 PM, Ola Lilja <ola.o.lilja@stericsson.com> wrote:

> Calling clk_set_parent (e.g. from Ux500 ASoC-driver) generates
> boot-errors.
>
> Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>

Also queued for 3.4.

Thanks,
Linus Walleij
