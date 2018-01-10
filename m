From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] ASoC: ux500: add MODULE_LICENSE tag
Date: Wed, 10 Jan 2018 21:42:43 +0100
Message-ID: <CACRpkdYfviDhawP7VrcwLWtED8s4O90Yyg6rT9r26tQwBHO+HA@mail.gmail.com>
References: <20180110163503.603206-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110163503.603206-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Donglin Peng <dolinux.peng@gmail.com>, Johan Hovold <johan@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 10, 2018 at 5:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> This adds MODULE_LICENSE/AUTHOR/DESCRIPTION tags to the ux500
> platform drivers, to avoid these build warnings:
>
> WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-plat-dma.o
> WARNING: modpost: missing MODULE_LICENSE() in sound/soc/ux500/snd-soc-ux500-mach-mop500.o
>
> The company no longer exists, so the email addresses of the authors
> don't work any more, but I've added them anyway for consistency.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
