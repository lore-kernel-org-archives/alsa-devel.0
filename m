From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] MPC5200: Eliminate duplicate include of
	of_device.h
Date: Tue, 23 Nov 2010 14:53:53 +0000
Message-ID: <20101123145352.GM18960@rakim.wolfsonmicro.main>
References: <alpine.LNX.2.00.1011222246250.6285@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D9B7103A84
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 15:53:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1011222246250.6285@swampdragon.chaosbits.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 22, 2010 at 10:54:03PM +0100, Jesper Juhl wrote:
> 
> Eliminate duplicate  #include <linux/of_device.h>  from 
> sound/soc/fsl/mpc5200_dma.c

Applied, thanks.
