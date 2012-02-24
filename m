From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
Date: Fri, 24 Feb 2012 23:23:29 +0000
Message-ID: <20120224232329.GE15120@n2100.arm.linux.org.uk>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<20120224140200.GH5450@opensource.wolfsonmicro.com>
	<20120224142342.GA16659@S2101-09.ap.freescale.net>
	<20120224141705.GJ5450@opensource.wolfsonmicro.com>
	<20120224232148.GA24268@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id B058A103C67
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 00:23:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120224232148.GA24268@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 25, 2012 at 07:21:51AM +0800, Shawn Guo wrote:
> On Fri, Feb 24, 2012 at 02:17:06PM +0000, Mark Brown wrote:
> > On Fri, Feb 24, 2012 at 10:23:45PM +0800, Shawn Guo wrote:
> > > On Fri, Feb 24, 2012 at 02:02:01PM +0000, Mark Brown wrote:
> > 
> > > > Please don't post new threads as followups to old threads, it makes
> > > > things harder to follow in threaded mail readers.
> > 
> > > I did that because they are a big series, though some of the patches
> > > can be standalone.
> > 
> > That doesn't seem to be related to my point?  I'm asking you to not
> > reply to an old version of your patch series in order to post a new
> > version of it, just post the new version.
> 
> This is the first version of this series.

Your covering message for this series of six patches:

From: Shawn Guo <shawn.guo@linaro.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
Date: Fri, 24 Feb 2012 22:09:35 +0800
Message-Id: <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Your patch 1 from a previous series:

From: Shawn Guo <shawn.guo@linaro.org>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/4] ASoC: imx: let SND_MXC_SOC_FIQ select FIQ
Date: Thu, 23 Feb 2012 14:47:21 +0800
Message-Id: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Notice the same message ids.  That means your covering letter with
subject "[PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl" is a reply
to your "[PATCH 1/4] ASoC: imx: let SND_MXC_SOC_FIQ select FIQ" message.

Consequently anyone who reads list mail by threads gets your new series
of six patches attached to your previous series of four patches.  That
can be extremely annoying, especially when it ends up being buried in
peoples mailboxes as a direct result of threaded sorting - and it's
a recipe for your patches to be ignored.
