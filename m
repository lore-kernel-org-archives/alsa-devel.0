From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 3/6] ASoC: OMAP: Add header for HDMI CPU DAI
Date: Thu, 05 May 2011 16:10:07 -0500
Message-ID: <1304629807.1900.112.camel@sagan>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
	<1304580113-24819-4-git-send-email-ricardo.neri@ti.com>
	<20110505082540.GH11744@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 558FC10381C
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 23:09:59 +0200 (CEST)
In-Reply-To: <20110505082540.GH11744@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, den 05.05.2011, 03:25 -0500 schrieb Mark Brown:
> On Thu, May 05, 2011 at 02:21:50AM -0500, Ricardo Neri wrote:
> > This header contains definitions used by the ASoC HDMI CPU DAI.
> > These are used to define the DMA port as well as the supported
> > audio sample formats and rates.
> 
> Just include this as part of the driver.
I will merge with the driver patch.
