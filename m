From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsi codecs: modify menu attribute on
	Kconfig
Date: Fri, 10 Sep 2010 12:39:38 +0100
Message-ID: <20100910113938.GH7259@rakim.wolfsonmicro.main>
References: <w3pvd6enzyv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A1E411039BC
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 13:39:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3pvd6enzyv.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Guennadi <g.liakhovetski@gmx.de>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 10, 2010 at 10:34:32AM +0900, Kuninori Morimoto wrote:
> Current SND_FSI_xxx menu attributes were bool,
> but it should be tristate.
> This patch solve below report from Guennadi

Applied, thanks.
