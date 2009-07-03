From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Zoom2: Update twl4030_setup_data
	parameters
Date: Fri, 3 Jul 2009 11:03:52 +0100
Message-ID: <20090703100352.GB29130@rakim.wolfsonmicro.main>
References: <2256F256009DAA4CBE661E9F41EAC84B5214663B@dlee01.ent.ti.com>
	<200907030850.03832.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6198D247F2
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 12:03:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200907030850.03832.peter.ujfalusi@nokia.com>
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

On Fri, Jul 03, 2009 at 08:50:03AM +0300, Peter Ujfalusi wrote:
> On Friday 03 July 2009 03:04:07 ext Candelaria Villareal, Jorge wrote:

> > Add support for EXTMUTE in Zoom2 machine driver. This is necessary
> > to further reduce pop noise problem. Signal EXTMUTE is connected to
> > signal GPIO 153 in Zoom2 board.

> > Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>

> Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Applied, thanks.
