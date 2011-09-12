From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound/soc/kirkwood/kirkwood-i2s.c: fix
 trivial build regression
Date: Mon, 12 Sep 2011 11:49:51 +0100
Message-ID: <20110912104951.GC2953@opensource.wolfsonmicro.com>
References: <1313820761-12042-1-git-send-email-julia@diku.dk>
	<3099701.CcMbBAJgz4@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A8C8D1039B9
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 12:49:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3099701.CcMbBAJgz4@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Julia Lawall <julia@diku.dk>, Liam Girdwood <lrg@ti.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 11, 2011 at 08:07:30PM +0200, Arnd Bergmann wrote:
> A fix merged in 3.1-rc2 introduced a small regression, this should get it
> to build again.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.

Please try to make sure that your commit logs match the style of the
subsystem.
