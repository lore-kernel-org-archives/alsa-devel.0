From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 3.1
Date: Sun, 21 Aug 2011 17:00:07 +0100
Message-ID: <20110821160006.GA13367@opensource.wolfsonmicro.com>
References: <20110821120843.GA12673@opensource.wolfsonmicro.com>
	<s5hvctq7u66.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D19E24417
	for <alsa-devel@alsa-project.org>;
	Sun, 21 Aug 2011 18:00:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hvctq7u66.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 21, 2011 at 03:47:45PM +0200, Takashi Iwai wrote:
> At Sun, 21 Aug 2011 13:08:43 +0100,
> Mark Brown wrote:

> > The biggest change here is cleaning up the ad193x mess - there appear to
> > have been quite a few issues on top of the entertainment with the
> > register I/O.

> Don't we need a similar fix for cs4271, too?

Not to my knowledge, this is the first time I've heard anyone mention
it and nobody's reported any problems.
