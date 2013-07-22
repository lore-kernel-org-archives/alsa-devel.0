From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: mxs: Depends on COMMON_CLK
Date: Mon, 22 Jul 2013 20:50:35 +0800
Message-ID: <20130722125034.GM20271@S2101-09.ap.freescale.net>
References: <1374491987-28645-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 92504261A49
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 14:50:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1374491987-28645-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 22, 2013 at 12:19:47PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> The SAIF driver is a clock provider so specifically needs the common
> clock implementedation.
> 
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Mark Brown <broonie@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
