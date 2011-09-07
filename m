From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 60/62] sound: irq: Remove IRQF_DISABLED
Date: Wed, 7 Sep 2011 10:12:56 -0700
Message-ID: <20110907171256.GB2906@opensource.wolfsonmicro.com>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
	<1315383059-3673-61-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 551DE243A6
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Sep 2011 19:13:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1315383059-3673-61-git-send-email-yong.zhang0@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <linux@arm.linux.org.uk>, Jassi Brar <jassisinghbrar@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Axel Lin <axel.lin@gmail.com>, Liam Girdwood <lrg@ti.com>, cbe-oss-dev@lists.ozlabs.org, Wan ZongShun <mcuos.com@gmail.com>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, tglx@linutronix.de, mingo@elte.hu, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Eric Miao <eric.y.miao@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, Geoff Levand <geoff@infradead.org>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <simon@horms.net>, Joe Perches <joe@perches.com>, linuxppc-dev@lists.ozlabs.
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 07, 2011 at 04:10:57PM +0800, Yong Zhang wrote:
> This flag is a NOOP and can be removed now.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
