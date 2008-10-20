From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: davinci_request_dma()
Date: Mon, 20 Oct 2008 10:49:50 +0100
Message-ID: <20081020094949.GA18798@sirena.org.uk>
References: <520f0cf10810160158y67c8330fg959f198d9026d680@mail.gmail.com>
	<20081016090810.GA3539@sirena.org.uk>
	<520f0cf10810160224o6fdc5235s946578544b9034f1@mail.gmail.com>
	<20081016100135.GC3539@sirena.org.uk>
	<520f0cf10810160305y673ba91btaf53e5ce4682aa77@mail.gmail.com>
	<20081016120837.GD3539@sirena.org.uk>
	<520f0cf10810200217t10193b1el7c69809b593866cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2696C1037E3
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 11:50:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <520f0cf10810200217t10193b1el7c69809b593866cb@mail.gmail.com>
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

On Mon, Oct 20, 2008 at 11:17:41AM +0200, John Kacur wrote:

> PXA appears to be incomplete too! s3c24xx looks like the only one that
> might work. (at least with 2.6.26 mainline). If I'm not mistaken PXA
> must also be living in an external git tree, and is only partially
> implemented in the mainline kernel.

What makes you say this?  I do a very large part of my development with
mainline PXA boards.
