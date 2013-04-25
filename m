From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 4/4] ASoC: imx-sgtl5000: Convert to
	devm_clk_get()
Date: Thu, 25 Apr 2013 13:21:17 +0800
Message-ID: <20130425052115.GD1389@S2101-09.ap.freescale.net>
References: <1366815286-31820-1-git-send-email-festevam@gmail.com>
 <1366815286-31820-4-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id C146E265D4C
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 07:21:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1366815286-31820-4-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 24, 2013 at 11:54:46AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Converting to devm_clk_get() can simplify the code a bit.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
