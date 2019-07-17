From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 3/6] ASoC: sgtl5000: Fix definition of VAG Ramp Control
Date: Wed, 17 Jul 2019 13:49:00 -0300
Message-ID: <CAOMZO5AGL_+NOMP4JcPS_eSJSXTNSYDf4A0m=zdgjRd7vhnhGg@mail.gmail.com>
References: <20190717163014.429-1-oleksandr.suvorov@toradex.com> <20190717163014.429-4-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190717163014.429-4-oleksandr.suvorov@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Igor Opaniuk <igor.opaniuk@toradex.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 17, 2019 at 1:30 PM Oleksandr Suvorov
<oleksandr.suvorov@toradex.com> wrote:
>
> SGTL5000_SMALL_POP is a bit mask, not a value. Usage of
> correct definition makes device probing code more clear.
>
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
