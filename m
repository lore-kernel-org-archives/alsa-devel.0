From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 3/5] ASoC: OMAP: Add CPU DAI driver for
	HDMI
Date: Sun, 15 May 2011 08:56:07 -0700
Message-ID: <20110515155606.GC26637@opensource.wolfsonmicro.com>
References: <1305452195-19177-1-git-send-email-ricardo.neri@ti.com>
	<1305452195-19177-4-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C61B24390
	for <alsa-devel@alsa-project.org>;
	Sun, 15 May 2011 17:56:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1305452195-19177-4-git-send-email-ricardo.neri@ti.com>
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
Cc: alsa-devel@alsa-project.org, tomi.valkeinen@ti.com, lrg@ti.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sun, May 15, 2011 at 04:36:33AM -0500, Ricardo Neri wrote:
> Addition of the HDMI CPU DAI driver for OMAP4. This driver is in
> charge of configuring DMA settings for HDMI. Also, it finds
> the HDMI video device and determines if audio playback can proceed.
> 
> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
