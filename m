From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3 0/3] ALSA SoC: MPC5200 audio driver
Date: Tue, 22 Jul 2008 10:14:36 -0500
Message-ID: <4885F95C.7060600@freescale.com>
References: <fa686aa40807212358p17c824ia1d6516a87a7aac1@mail.gmail.com>	
	<20080722092646.GA7251@sirena.org.uk>	
	<9e4733910807220638u5cf48424l92ba780ecd9e3d9d@mail.gmail.com>	
	<20080722141027.GB12555@sirena.org.uk>
	<9e4733910807220752o4d220f90o770d55e70f493642@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 03C3E24661
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 17:14:42 +0200 (CEST)
In-Reply-To: <9e4733910807220752o4d220f90o770d55e70f493642@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:

> I'm just going to ignore 2.6.27 and wait for 2.6.28.

2.6.28 might have ASoC V2, or at least portions of it.  You might want to just
port your driver to ASoC V2 like I did and not worry about it.

-- 
Timur Tabi
Linux kernel developer at Freescale
