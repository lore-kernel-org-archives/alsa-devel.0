From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: wm8731: set the ACTIVE bit if bias
	ON entered
Date: Tue, 5 Jul 2011 21:27:09 +0100
Message-ID: <20110705202709.GA26404@sirena.org.uk>
References: <ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com> <1309517034-26110-1-git-send-email-nicolas.ferre@atmel.com> <20110701161506.GC23784@opensource.wolfsonmicro.com> <4E118BF6.6010205@atmel.com> <20110704172856.GF28726@opensource.wolfsonmicro.com> <4E12C426.8050501@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4E12C426.8050501@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: lrg@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 05, 2011 at 09:58:30AM +0200, Nicolas Ferre wrote:

> I have replaced this with ACTIVE to match the route declaration.

> *With this modification* it works, so you can add my:

> Tested-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Great, thanks.
