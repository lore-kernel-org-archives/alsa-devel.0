From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [uclinux-dist-devel] [PATCH 3.0]ASoC: ad193x: add
 spi_hw_read, fix sysclk and register definition
Date: Fri, 12 Aug 2011 13:17:04 +0900
Message-ID: <1313122624.19990.43.camel@finisterre.wolfsonmicro.main>
References: <CAHG8p1B2HB61yooEsPwzw+4E60ffM2NUsb98yCsanfPnWD9vgA@mail.gmail.com>
	<DB904C5425BA6F4E8424B3B51A1414D16CA93F826F@NWD2CMBX1.ad.analog.com>
	<20110811133432.GA6067@kroah.com> <s5hpqkc83o2.wl%tiwai@suse.de>
	<CAHG8p1D8MrLZ6rGHOoc6QiEioYD3nYJftp7AedM2ja5uuWuDRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 63F2624356
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 06:17:16 +0200 (CEST)
In-Reply-To: <CAHG8p1D8MrLZ6rGHOoc6QiEioYD3nYJftp7AedM2ja5uuWuDRw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "Zhang,
	Sonic" <Sonic.Zhang@analog.com>, "stable@kernel.org" <stable@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-08-12 at 12:10 +0800, Scott Jiang wrote:

> Thanks, Takashi. I should send patch for 3.1 and cc stable tree.
> I have a question here that patch for 3.1 and 3.0 is different, who is
> responsible for the back patch?

The same people as normally handle patches.
