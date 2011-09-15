From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: bf5xx-ad73311: Fix prototype for
	bf5xx_probe
Date: Fri, 16 Sep 2011 00:50:44 +0100
Message-ID: <20110915235044.GH3218@opensource.wolfsonmicro.com>
References: <1316055896.3496.8.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AE6F7103C64
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 01:50:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1316055896.3496.8.camel@phoenix>
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
Cc: Cliff Cai <Cliff.Cai@analog.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 15, 2011 at 11:04:56AM +0800, Axel Lin wrote:
> Fix below build warning:
> sound/soc/blackfin/bf5xx-ad73311.c: warning: initialization from incompatible pointer type

Applied, thanks.
