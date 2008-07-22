From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 0/3] ALSA SoC: MPC5200 audio driver
Date: Tue, 22 Jul 2008 15:10:34 +0100
Message-ID: <20080722141027.GB12555@sirena.org.uk>
References: <fa686aa40807212358p17c824ia1d6516a87a7aac1@mail.gmail.com>
	<20080722092646.GA7251@sirena.org.uk>
	<9e4733910807220638u5cf48424l92ba780ecd9e3d9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AA60610387D
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 16:23:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807220638u5cf48424l92ba780ecd9e3d9d@mail.gmail.com>
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
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 22, 2008 at 09:38:11AM -0400, Jon Smirl wrote:

> These drivers are going to get hit with immediate patches.  The DMA is
> not broken out so that AC97 support can be fixed for the Efika.

Further updates shouldn't present a problem - if anything, it should be
easier easier to review incremental patches.
