From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] TLV320AIC3X MCLK and rate updates
Date: Wed, 20 Feb 2008 13:44:46 +0000
Message-ID: <20080220134446.GA21535@rakim.wolfsonmicro.main>
References: <1203513825-17158-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F3B67243A1
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 14:44:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1203513825-17158-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Vladimir Barinov <vbarinov@ru.mvista.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 20, 2008 at 03:23:43PM +0200, Jarkko Nikula wrote:

> Two patches to TLV320AIC3X SoC codec driver. First one fixes typo (?) 
> for 64 kHz sample rate and second one adds support to 12 MHz MCLK used
> e.g. in Nokia N810 Internet Tablet.

Thanks, I've applied both of these to the ASoC tree.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
