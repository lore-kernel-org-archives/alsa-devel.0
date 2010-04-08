From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: imx-ssi fixes
Date: Thu, 8 Apr 2010 16:54:55 +0100
Message-ID: <20100408155455.GB2710@rakim.wolfsonmicro.main>
References: <1270719086-23453-1-git-send-email-s.hauer@pengutronix.de>
	<20100408144750.GC14241@sirena.org.uk>
	<20100408155113.GM3688@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5BD11103984
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 17:54:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100408155113.GM3688@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Valentin Longchamp <valentin.longchamp@epfl.ch>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 08, 2010 at 05:51:13PM +0200, Sascha Hauer wrote:

> If you haven't pushed the patches forward it would be good to delay the
> hrtimer patch a bit. I managed to shoot the system down while playing
> audio with a hackbench 10. This doesn't happen without the hrtimer
> patch. This may be related to the problem Valentin reported.

Already pushed to Takashi, but he's not pulled yet.
