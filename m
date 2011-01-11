From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound: ASoC: fix migor audio build
Date: Tue, 11 Jan 2011 11:02:41 +0000
Message-ID: <20110111110241.GB12452@opensource.wolfsonmicro.com>
References: <Pine.LNX.4.64.1101110829080.3893@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A5BF31039F2
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 12:04:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1101110829080.3893@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 11, 2011 at 08:34:52AM +0100, Guennadi Liakhovetski wrote:
> Commit 6d803ba736abb5e122dede70a4720e4843dd6df4 "ARM: 6483/1: arm & sh: 
> factorised duplicated clkdev.c" broke compilation of migor audio. Use the 
> correct header to fix the problem.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.
