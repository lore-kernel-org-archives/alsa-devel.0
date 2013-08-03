From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH v3 1/4] ASoc: kirkwood: simplify probe error
Date: Sat, 3 Aug 2013 17:55:13 +0200
Message-ID: <20130803175513.7b765b0d@armhf>
References: <20130731081739.76aae84c@armhf>
	<20130803123954.GX23006@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130803123954.GX23006@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, 3 Aug 2013 13:39:54 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> This doesn't apply to mainline as there's a clk_put() there.

Right, it applies to linux-next:

On Fri, 26 Jul 2013 11:32:50 +0100, Mark Brown <broonie@kernel.org> wro=
te:

> Always submit against where the code will be applied - -next in this
> case.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
