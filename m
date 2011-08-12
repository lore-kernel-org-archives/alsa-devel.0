From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [uclinux-dist-devel] [PATCH 3.0]ASoC: ad193x: add
 spi_hw_read, fix sysclk and register definition
Date: Fri, 12 Aug 2011 11:44:07 +0900
Message-ID: <20110812024405.GB10218@opensource.wolfsonmicro.com>
References: <CAHG8p1B2HB61yooEsPwzw+4E60ffM2NUsb98yCsanfPnWD9vgA@mail.gmail.com>
	<DB904C5425BA6F4E8424B3B51A1414D16CA93F826F@NWD2CMBX1.ad.analog.com>
	<20110811133432.GA6067@kroah.com> <s5hpqkc83o2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D5EB4103967
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 04:44:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hpqkc83o2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Scott Jiang <scott.jiang.linux@gmail.com>, Greg KH <greg@kroah.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "Zhang,
	Sonic" <Sonic.Zhang@analog.com>, "stable@kernel.org" <stable@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 11, 2011 at 03:43:09PM +0200, Takashi Iwai wrote:

> Scott, the patch to stable kernel must have been applied to the
> upstream tree beforehand.  Read Documentation/stable_kernel_rules.txt.

It also still needs to get the same sort of review as something going
in via the normal routes.
