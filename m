From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: TWL4030: Add EXTMUTE to reduce
	pop-noise effect
Date: Thu, 2 Jul 2009 11:08:01 +0100
Message-ID: <20090702100801.GB6842@rakim.wolfsonmicro.main>
References: <2256F256009DAA4CBE661E9F41EAC84B52037758@dlee01.ent.ti.com>
	<200907021234.58110.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F2056246DE
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Jul 2009 12:08:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200907021234.58110.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ext Candelaria Villareal, Jorge" <x0107209@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 02, 2009 at 12:34:57PM +0300, Peter Ujfalusi wrote:
> On Thursday 02 July 2009 03:17:43 ext Candelaria Villareal, Jorge wrote:

> > According to TRM, an external FET controlled by a 1.8V output signal
> > can be used to reduce the pop-noise heard when the audio amplifier is
> > switched on. It is suggested that GPIO6 of TWL4030 be used, but any

> Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Applied, thanks.
