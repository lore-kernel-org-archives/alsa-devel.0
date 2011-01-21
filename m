From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3 v2] ASoC: fsi/ak4642/da7210: select
 sound format from fsi-codecs
Date: Fri, 21 Jan 2011 19:02:02 +0000
Message-ID: <20110121190202.GI22414@opensource.wolfsonmicro.com>
References: <w3pk4iay72i.wl%kuninori.morimoto.gx@renesas.com>
	<w3pei8iy6z6.wl%kuninori.morimoto.gx@renesas.com>
	<20110112145302.GA14870@opensource.wolfsonmicro.com>
	<20110113222844.GC20418@linux-sh.org>
	<w3pwrm0pa3u.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 52403103B16
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 20:02:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <w3pwrm0pa3u.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 20, 2011 at 11:44:37AM +0900, Kuninori Morimoto wrote:

> Kuninori Morimoto (3):
>       ASoC: ak4642: add SND_SOC_DAIFMT_FORMAT support
>       ASoC: sh: fsi: Add fsi_get_priv_frm_dai function
>       ASoC: sh: fsi: Add snd_soc_dai_set_fmt support

> I sent these patches and got Acked-by from Liam, Paul.
> But it were not applied to Mark's branch
> because these depend on merge window.

Applied, thanks.
