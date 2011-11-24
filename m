From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5][resend] ASoC: fsi-ak4642: modify
 specification method of FSI / ak464x
Date: Thu, 24 Nov 2011 10:45:46 +0000
Message-ID: <20111124104545.GC8470@opensource.wolfsonmicro.com>
References: <87y5vsqxiz.wl%kuninori.morimoto.gx@renesas.com>
	<87wrbcqxhn.wl%kuninori.morimoto.gx@renesas.com>
	<8762iagwzh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8CBD3244F0
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 11:45:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <8762iagwzh.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Paul Mundt <lethal@linux-sh.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 23, 2011 at 04:55:34PM -0800, Kuninori Morimoto wrote:
> Current fsi-ak4642 was using id_entry name in order to specify
> FSI port and ak464x codec.
> But it was no sense, no flexibility.
> Platform can specify FSI/ak464x pair by this patch.

Applied, thanks.
