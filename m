From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 2/2] ASoC: atmel: compile pcm driver in
 snd-soc-atmel_ssc_dai
Date: Wed, 27 May 2015 11:25:49 +0200
Message-ID: <1432718749.27695.254.camel@x220>
References: <1432591459-22613-1-git-send-email-alexandre.belloni@free-electrons.com>
	 <1432591459-22613-2-git-send-email-alexandre.belloni@free-electrons.com>
	 <1432713024.27695.235.camel@x220> <20150527091902.GN3199@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150527091902.GN3199@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-05-27 at 11:19 +0200, Alexandre Belloni wrote:
> However, the Kconfig maintainer found a way to do the right thing so we
> may as well drop that patch and keep those as modules.

Perhaps I missed a message: do you have a link?

(I fiddled a bit with the build setup of these drivers too, but then
noticed that the patch was already applied, and abandoned that.)

Thanks,


Paul Bolle
