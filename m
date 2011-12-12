From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/10] ASoC: OMAP: ams-delta: Drive modem/codec pins over
 GPIO API
Date: Mon, 12 Dec 2011 12:29:50 +0800
Message-ID: <20111212042949.GA2806@opensource.wolfsonmicro.com>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <1323634328-856-8-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1323634328-856-8-git-send-email-jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 11, 2011 at 09:12:05PM +0100, Janusz Krzysztofik wrote:
> Don't use Amstrad Delta custom I/O functions any longer, replace them
> with GPIO. Old pin definitions, no longer used by the modem bits either,
> can be dropped.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
