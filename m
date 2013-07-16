From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: imx: Enable COMPILE_TEST builds
Date: Tue, 16 Jul 2013 20:12:45 +0800
Message-ID: <20130716121243.GJ28375@S2101-09.ap.freescale.net>
References: <1373904242-30250-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 04BB6264F0B
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 14:14:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1373904242-30250-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 15, 2013 at 05:04:02PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Since DT based boards don't have any dependency on arch/arm enable them
> if COMPILE_TEST is enabled.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
