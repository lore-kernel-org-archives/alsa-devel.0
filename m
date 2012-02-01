From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] ARM: ux500: Add placeholder for
	clk_set_parent
Date: Wed, 1 Feb 2012 20:55:11 +0100
Message-ID: <CACRpkda2UZxbN0oCN3_E9JaVuN=5OVefK=R44Ra5=VzghYD77Q@mail.gmail.com>
References: <1327933094-22155-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C60B103847
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2012 20:55:14 +0100 (CET)
Received: by iabz21 with SMTP id z21so2242059iab.38
	for <alsa-devel@alsa-project.org>; Wed, 01 Feb 2012 11:55:11 -0800 (PST)
In-Reply-To: <1327933094-22155-1-git-send-email-ola.o.lilja@stericsson.com>
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

On Mon, Jan 30, 2012 at 3:18 PM, Ola Lilja <ola.o.lilja@stericsson.com> wrote:

> Calling clk_set_parent (e.g. from Ux500 ASoC-driver) generates
> build-errors.
>
> Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>

OK applied this to ux500-core.

Yours,
Linus Walleij
