From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
Date: Fri, 24 Feb 2012 22:23:45 +0800
Message-ID: <20120224142342.GA16659@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<20120224140200.GH5450@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BA4E1042C4
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 15:10:13 +0100 (CET)
Received: by dady9 with SMTP id y9so2740766dad.38
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 06:10:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120224140200.GH5450@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 24, 2012 at 02:02:01PM +0000, Mark Brown wrote:
> On Fri, Feb 24, 2012 at 10:09:35PM +0800, Shawn Guo wrote:
> > This is the third series towards reusing fsl_ssi driver on device tree
> > based IMX platforms.  It makes a few cleanups on existing PowerPC code
> > to ease the later addition of an IMX machine driver that works on
> > fsl_ssi.
> 
> Please don't post new threads as followups to old threads, it makes
> things harder to follow in threaded mail readers.

I did that because they are a big series, though some of the patches
can be standalone.

-- 
Regards,
Shawn
