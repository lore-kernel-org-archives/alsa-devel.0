From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: SSM2602: add SPI support
Date: Fri, 8 Apr 2011 09:35:05 +0900
Message-ID: <20110408003504.GG9827@opensource.wolfsonmicro.com>
References: <1302156311-16536-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A32E24335
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 02:34:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1302156311-16536-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: alsa-devel@alsa-project.org, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 07, 2011 at 02:05:11AM -0400, Mike Frysinger wrote:
> The ssm2602 codec has a SPI interface as well as I2C, so add the simple
> bit of glue to make it usable.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Applied, but the patch didn't apply cleanly - please check that I
resolved it OK.
