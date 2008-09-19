From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC V2: Remove check for fsl,
	eloplus-dma-channel from	MPC8610 sound driver
Date: Fri, 19 Sep 2008 13:08:57 +0100
Message-ID: <20080919120857.GA27175@rakim.wolfsonmicro.main>
References: <1221775045-13290-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B3AFA24471
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Sep 2008 14:08:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1221775045-13290-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 18, 2008 at 04:57:25PM -0500, Timur Tabi wrote:
> Remove the check in the Freescale MPC8610 sound driver for the "compatible"
> property in the DMA channels.

Applied, thanks.
