From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] fbdev: sh_mobile_hdmi: fix compilation
 without SOUND enabled
Date: Fri, 15 Oct 2010 11:56:31 +0100
Message-ID: <1287140191.3271.25.camel@odin>
References: <Pine.LNX.4.64.1010150841280.3945@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D3D15103C45
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 12:56:39 +0200 (CEST)
Received: by bwz18 with SMTP id 18so1189475bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2010 03:56:39 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1010150841280.3945@axis700.grange>
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
Cc: alsa-devel@alsa-project.org, Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kuninori@alsa-project.org, Paul Mundt <lethal@linux-sh.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-10-15 at 08:58 +0200, Guennadi Liakhovetski wrote:
> At least two more Kconfig options have to be selected to be able to compile
> sh_mobile_hdmi.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> 
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
