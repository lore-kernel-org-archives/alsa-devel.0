From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: make comments fit the code
Date: Tue, 19 Jul 2011 16:21:30 +0100
Message-ID: <20110719152130.GI9652@opensource.wolfsonmicro.com>
References: <1310918426-24194-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 255F224574
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jul 2011 17:21:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1310918426-24194-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 17, 2011 at 06:00:26PM +0200, Wolfram Sang wrote:
> In one comment, cpu_dai was mentioned although codec_dai was used in the
> code. Also, fix the name for the card dai list which has no seperation
> into card_dai and codec_dai.

Applied, thanks.
