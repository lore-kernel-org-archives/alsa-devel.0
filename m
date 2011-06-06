From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/6] ASoC: AD1836: Add
	AD1835/AD1837/AD1838/AD1839 support
Date: Mon, 6 Jun 2011 21:53:11 +0100
Message-ID: <20110606205310.GA27341@opensource.wolfsonmicro.com>
References: <1307360320-4727-1-git-send-email-lars@metafoo.de>
	<1307360320-4727-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ABA48244A5
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 22:53:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307360320-4727-4-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, device-drivers-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 06, 2011 at 01:38:38PM +0200, Lars-Peter Clausen wrote:
> The AD183X codec devices are mostly register compatible and can easily be
> supported by the same driver.
> The main difference between those devices is the number of DACs and ADCs.

Please try to fix whatever it is gives this really weird word wrapping
in your changelogs - they frequently have line breaks in the middle of
paragraphs for some reason.
