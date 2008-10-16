From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: davinci_request_dma()
Date: Thu, 16 Oct 2008 13:08:38 +0100
Message-ID: <20081016120837.GD3539@sirena.org.uk>
References: <520f0cf10810160158y67c8330fg959f198d9026d680@mail.gmail.com>
	<20081016090810.GA3539@sirena.org.uk>
	<520f0cf10810160224o6fdc5235s946578544b9034f1@mail.gmail.com>
	<20081016100135.GC3539@sirena.org.uk>
	<520f0cf10810160305y673ba91btaf53e5ce4682aa77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E02524552
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Oct 2008 14:08:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <520f0cf10810160305y673ba91btaf53e5ce4682aa77@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Kacur <jkacur@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 16, 2008 at 12:05:41PM +0200, John Kacur wrote:
> On Thu, Oct 16, 2008 at 12:01 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> > What are you looking to do - if you're looking for an ASoC driver for
> > DaVinici that's the only one I'm aware of.

> No, I'm looking at doing ASoC drivers in general, not for a DaVinci
> processor specifically.

PXA, OMAP or S3C24xx should all be good bets in terms of platform
support.  Out of interest, what are you working on?
