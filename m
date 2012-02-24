From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
Date: Fri, 24 Feb 2012 17:14:12 -0600
Message-ID: <4F4819C4.5040709@freescale.com>
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
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	by alsa0.perex.cz (Postfix) with ESMTP id D83EA104341
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 00:14:25 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
>> > That doesn't seem to be related to my point?  I'm asking you to not
>> > reply to an old version of your patch series in order to post a new
>> > version of it, just post the new version.

> This is the first version of this series.

I think there's a communication breakdown.  Shawn, take a look at this:

http://mailman.alsa-project.org/pipermail/alsa-devel/2012-February/thread.html

Search for "[alsa-devel] [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl".

You'll see that this email is indented, because it was posted to the
mailing list AS A REPLY to "[alsa-devel] [PATCH 1/4] ASoC: imx: let
SND_MXC_SOC_FIQ select FIQ".  That's because it has this line in the
message header:

In-Reply-To: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>

This is what Mark is talking about.  He wants new patch sets to be posted
NOT as replies to other patch sets.

-- 
Timur Tabi
Linux kernel developer at Freescale
