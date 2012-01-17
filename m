From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: omap-mcbsp: Use future proof
 OMAP version checks for configuration
Date: Tue, 17 Jan 2012 15:43:04 +0000
Message-ID: <20120117154304.GI2944@opensource.wolfsonmicro.com>
References: <1326806170-7425-1-git-send-email-peter.ujfalusi@ti.com>
	<1326806170-7425-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D630B2461C
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 16:43:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326806170-7425-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 17, 2012 at 02:16:10PM +0100, Peter Ujfalusi wrote:
> Change the cpu_is_ checks so that we do not need to change them when new
> SoC is available.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
