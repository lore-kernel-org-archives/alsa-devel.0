From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 00/11] JZ4740 SoC cleanup
Date: Fri, 26 Jul 2019 20:46:49 +0200
Message-ID: <20190726184649.GC14981@ravnborg.org>
References: <20190725220215.460-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725220215.460-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, linux-pm@vger.kernel.org, linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Hi Paul.

On Thu, Jul 25, 2019 at 06:02:04PM -0400, Paul Cercueil wrote:
> Hi,
> 
> This patchset converts the Qi LB60 MIPS board to devicetree and makes it
> use all the shiny new drivers that have been developed or updated
> recently.
> 
> All the crappy old drivers and custom code can be dropped since they
> have been replaced by better alternatives.

The overall diffstat is missing.
Just for curiosity it would be nice to see what was dropped with this
patch.

	Sam
