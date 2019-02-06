From: Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2 1/2] ASoC: ssm2602: switch to SPDX
	identifier
Date: Wed, 6 Feb 2019 17:29:08 +0100
Message-ID: <20190206162908.s7ese6lgcyrxdike@pengutronix.de>
References: <20190206152947.2789-1-m.felsch@pengutronix.de>
 <20190206153244.GB17630@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A1B826792A
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 17:29:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20190206153244.GB17630@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 19-02-06 15:32, Mark Brown wrote:
> On Wed, Feb 06, 2019 at 04:29:46PM +0100, Marco Felsch wrote:
> 
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> >  /*
> >   * File:         sound/soc/codecs/ssm2602.c
> >   * Author:       Cliff Cai <Cliff.Cai@analog.com>
> 
> Please convert the entire comment to C++ style so it looks more
> intentional and is consistent with other ASoC stuff.

Okay, I will do this in the v3.

Regards,
Marco

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
