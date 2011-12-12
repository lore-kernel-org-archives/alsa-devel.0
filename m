From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 2/5] ASoC: mxs: add .owner to struct
 snd_soc_card
Date: Mon, 12 Dec 2011 18:04:03 +0800
Message-ID: <20111212100402.GC31568@opensource.wolfsonmicro.com>
References: <cover.1323436034.git.LW@KARO-electronics.de>
 <555be1750dd09586d5eede6457f72310890274b0.1323436034.git.LW@KARO-electronics.de>
 <20111209141203.GH3327@pengutronix.de>
 <20194.7382.414612.182139@ipc1.ka-ro>
 <20111211025358.GB2800@opensource.wolfsonmicro.com>
 <20197.50444.333155.552035@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20197.50444.333155.552035@ipc1.ka-ro>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>, alsa-devel@alsa-project.org, Dong Aisheng-B29396 <B29396@freescale.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 12, 2011 at 10:10:36AM +0100, Lothar Wa=DFmann wrote:

> There are 84 drivers affected by this. I did not check though whether
> all of them are compilable as module.
> I could provide a patch for all of these, but I can at most do a
> compile testing for some of them.

Compile only testing is absolutely fine.
