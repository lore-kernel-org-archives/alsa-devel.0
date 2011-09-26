From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Drop exporting ad1980_dai
Date: Mon, 26 Sep 2011 09:58:53 +0100
Message-ID: <20110926085853.GC2946@opensource.wolfsonmicro.com>
References: <1316861023.11157.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B501103836
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 10:58:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1316861023.11157.4.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Roy Huang <roy.huang@analog.com>, Cliff Cai <cliff.cai@analog.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 24, 2011 at 06:43:43PM +0800, Axel Lin wrote:
> ad1980_dai is not used outside this driver,
> thus drop exporting it.

Applied, thanks.
