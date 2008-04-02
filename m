From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC for TI OMAP - alsa-devel submission?
Date: Wed, 2 Apr 2008 12:00:54 +0100
Message-ID: <20080402110054.GA7977@rakim.wolfsonmicro.main>
References: <20080402134530.3460b0bf.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 00FCA2442A
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Apr 2008 13:00:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080402134530.3460b0bf.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 02, 2008 at 01:45:30PM +0300, Jarkko Nikula wrote:

> So what I mean that should I post the patch like as it now, rebased to
> dev branch of linux-2.6-asoc tree and with some minor changes, or wait a
> bit when all linux-omap and ASoC v2 evolve? What you think?

Whatever is most convenient for you.  From the point of view of getting
stuff in immediately it's best to base things on ASoC v1 though from an
ongoing development point of view ASoC v2 is a better target if you can
cope with any churn and hopefully we should be starting to push it into
the kernel within the next couple of release cycles so if it's going to
take a while to get the required BSP changes in...
