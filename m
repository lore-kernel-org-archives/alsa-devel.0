From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix recursive dependency for
	SND_ATMEL_SOC_SSC
Date: Tue, 10 Jan 2012 03:30:37 +0000
Message-ID: <20120110033037.GN30766@opensource.wolfsonmicro.com>
References: <1326159191-11775-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 500DD244FB
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 04:30:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326159191-11775-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, axel.lin@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 09, 2012 at 11:33:11PM -0200, Fabio Estevam wrote:
> commit 739be96 (ASoC: Fix build dependency for SND_ATMEL_SOC_SSC) introduced the following
> recursive dependency:

Already fixed.
