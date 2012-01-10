From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix build dependency for
	SND_AT91_SOC_AFEB9260
Date: Mon, 9 Jan 2012 20:20:50 -0800
Message-ID: <20120110042048.GA31212@opensource.wolfsonmicro.com>
References: <1325836319.22753.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 887D3103AB6
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 05:20:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1325836319.22753.0.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Paul Bolle <pebolle@tiscali.nl>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 06, 2012 at 03:51:59PM +0800, Axel Lin wrote:
> Make SND_AT91_SOC_AFEB9260 depend on ATMEL_SSC to fix below build errors:

Applied, thanks.
