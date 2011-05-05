From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/6] ASoC: OMAP: Add header for HDMI CPU DAI
Date: Thu, 5 May 2011 09:25:40 +0100
Message-ID: <20110505082540.GH11744@opensource.wolfsonmicro.com>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
	<1304580113-24819-4-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2C51B10393D
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 10:26:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304580113-24819-4-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, May 05, 2011 at 02:21:50AM -0500, Ricardo Neri wrote:
> This header contains definitions used by the ASoC HDMI CPU DAI.
> These are used to define the DMA port as well as the supported
> audio sample formats and rates.

Just include this as part of the driver.
