From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: add phycore-ac97 sound support
Date: Wed, 25 Nov 2009 15:43:10 +0000
Message-ID: <20091125154309.GB12750@rakim.wolfsonmicro.main>
References: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
	<1259163666-30344-2-git-send-email-s.hauer@pengutronix.de>
	<1259163666-30344-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 17B1A243C0
	for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2009 16:43:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1259163666-30344-3-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 25, 2009 at 04:41:05PM +0100, Sascha Hauer wrote:

> +#include "../codecs/mc13783.h"

Bitrot (and won't build right now as a result).  Otherwise this looks OK
to me.
