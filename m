From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/4] ASoC: omap-mcpdm/twl6040: Offset
	cancellation
Date: Thu, 15 Sep 2011 15:42:50 +0100
Message-ID: <20110915144250.GQ7988@opensource.wolfsonmicro.com>
References: <1316090718-30822-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 736AE10388D
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 16:42:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1316090718-30822-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 15, 2011 at 03:45:14PM +0300, Peter Ujfalusi wrote:
> Hello,
> 
> The following series adds support for the McPDM offset cancellation feature.
> It provides the needed functionality to:
> - read the HSTRIM values from the twl6040 codec
> - configure the offset cancellation registers in OMAP-McPDM

All

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
