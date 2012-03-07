From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2 00/17] ASoC: add imx-sgtl5000 machine
 driver working with fsl_ssi
Date: Wed, 7 Mar 2012 17:18:31 -0600
Message-ID: <4F57ECC7.1040100@freescale.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
	(am1ehsobe003.messaging.microsoft.com [213.199.154.206])
	by alsa0.perex.cz (Postfix) with ESMTP id E58BF24151
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 00:18:43 +0100 (CET)
In-Reply-To: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
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
> Changes since v1:
>  * Address comments from Mark, Timur, and Sascha (Thanks for review).
>  * Drop patches that have been applied by Mark.

I've tested this patchset, and after adding the changes that I pointed out
in my previous email, audio still works on the P1022DS and MPC8610HPCD.

Therefore:

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
