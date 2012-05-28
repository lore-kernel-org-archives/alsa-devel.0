From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 15/15] ASoC: mxs-saif: Use
 clk_prepare_enable/clk_disable_unprepare
Date: Mon, 28 May 2012 15:51:17 +0100
Message-ID: <20120528145117.GI4032@opensource.wolfsonmicro.com>
References: <1337987696-31728-1-git-send-email-festevam@gmail.com>
	<1337987696-31728-15-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7041324372
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2012 16:51:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1337987696-31728-15-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@freescale.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Fri, May 25, 2012 at 08:14:56PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Prepare the clock before enabling it.

Applied, thanks.
