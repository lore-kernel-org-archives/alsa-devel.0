From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] ASoC: SSM2602: Fix default register
	cache
Date: Mon, 9 May 2011 01:46:19 +0200
Message-ID: <20110508234619.GC20411@opensource.wolfsonmicro.com>
References: <20110508135613.GA15968@opensource.wolfsonmicro.com>
	<1304871886-18509-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ABD4C1037FF
	for <alsa-devel@alsa-project.org>;
	Mon,  9 May 2011 01:46:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304871886-18509-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mike Frysinger <vapier@gentoo.org>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, May 08, 2011 at 09:24:41AM -0700, Lars-Peter Clausen wrote:
> Some of the values in the default register cache did not represent the codecs
> state after reset. This patch fixes it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied all, thanks.
