From: "John Kacur" <jkacur@gmail.com>
Subject: Re: davinci_request_dma()
Date: Thu, 16 Oct 2008 15:31:56 +0200
Message-ID: <520f0cf10810160631y56dcd51dn619fdaec8c99d868@mail.gmail.com>
References: <520f0cf10810160158y67c8330fg959f198d9026d680@mail.gmail.com>
	<20081016090810.GA3539@sirena.org.uk>
	<520f0cf10810160224o6fdc5235s946578544b9034f1@mail.gmail.com>
	<20081016100135.GC3539@sirena.org.uk>
	<520f0cf10810160305y673ba91btaf53e5ce4682aa77@mail.gmail.com>
	<20081016120837.GD3539@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f24.google.com (mail-gx0-f24.google.com
	[209.85.217.24]) by alsa0.perex.cz (Postfix) with ESMTP id BABFF24153
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Oct 2008 15:32:14 +0200 (CEST)
Received: by gxk5 with SMTP id 5so1898122gxk.8
	for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2008 06:31:56 -0700 (PDT)
In-Reply-To: <20081016120837.GD3539@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 16, 2008 at 2:08 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Thu, Oct 16, 2008 at 12:05:41PM +0200, John Kacur wrote:
>> On Thu, Oct 16, 2008 at 12:01 PM, Mark Brown <broonie@sirena.org.uk> wrote:
>
>> > What are you looking to do - if you're looking for an ASoC driver for
>> > DaVinici that's the only one I'm aware of.
>
>> No, I'm looking at doing ASoC drivers in general, not for a DaVinci
>> processor specifically.
>
> PXA, OMAP or S3C24xx should all be good bets in terms of platform
> support.  Out of interest, what are you working on?
>

arm Jade + max5556
