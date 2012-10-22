From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: Ux500: Fixup complile errors due to merge
Date: Mon, 22 Oct 2012 09:30:45 +0100
Message-ID: <20121022083045.GA3785@gmail.com>
References: <1350653427-28611-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1350653427-28611-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 19 Oct 2012, Ulf Hansson wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>=20
> Likely during merge of the below commits ended up breaking compilatio=
n:
> ASoC: Ux500: Enable ux500 MSP driver for Device Tree
> ASoC: ux500_msp_i2s: better use devm functions and fix error return c=
ode

This is already fixed:
  https://patchwork.kernel.org/patch/1593881/

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
