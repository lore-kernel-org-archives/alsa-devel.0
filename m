From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 0/4] Fixes resource leaks for Samsung SoCs
Date: Mon, 29 Nov 2010 11:01:27 +0000
Message-ID: <20101129110127.GO30360@rakim.wolfsonmicro.main>
References: <1290754245.25125.1.camel@mola>
 <AANLkTi=A7LcN6Eoh8WnT2g5TBpFb12ogWncYjZzFeZg3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=A7LcN6Eoh8WnT2g5TBpFb12ogWncYjZzFeZg3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, Maurus Cuelenaere <mcuelenaere@gmail.com>, Graeme Gregory <graeme@openmoko.org>, Chanwoo Choi <cw00.choi@samsung.com>, Seungwhan Youn <sw.youn@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 29, 2010 at 08:40:29AM +0900, Jassi Brar wrote:
> On Fri, Nov 26, 2010 at 3:50 PM, Axel Lin <axel.lin@gmail.com> wrote:
> > Axel Lin (4):
> > =A0ASoC: Fix resource leask in goni_wm8994.c
> > =A0ASoC: Fix resource leask in neo1973_gta02_init() error path
> > =A0ASoC: Add missing gpio_free(S3C64XX_GPK(12)) in smartq_exit()
> > =A0ASoC: Fix resource leask in smdk_spdif.c

> Acked-by: Jassi Brar <jassi.brar@samsung.com>

All applied now, thanks.
