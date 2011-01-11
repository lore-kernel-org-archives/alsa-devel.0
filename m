From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] sound: ASoC: fix migor audio build
Date: Tue, 11 Jan 2011 10:51:52 +0000
Message-ID: <1294743112.3338.2.camel@odin>
References: <Pine.LNX.4.64.1101110829080.3893@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6948B10397E
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 11:51:56 +0100 (CET)
Received: by mail-wy0-f179.google.com with SMTP id 11so20421763wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 02:51:56 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-01-11 at 08:34 +0100, Guennadi Liakhovetski wrote:
> Commit 6d803ba736abb5e122dede70a4720e4843dd6df4 "ARM: 6483/1: arm & sh: 
> factorised duplicated clkdev.c" broke compilation of migor audio. Use the 
> correct header to fix the problem.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
