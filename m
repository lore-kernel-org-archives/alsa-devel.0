From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ASoC: fsi: simultaneous
	playback/recorde support
Date: Fri, 15 Oct 2010 11:06:15 +0100
Message-ID: <20101015100615.GD14782@rakim.wolfsonmicro.main>
References: <w3pbp70rpoq.wl%kuninori.morimoto.gx@renesas.com>
	<w3paamkrpn6.wl%kuninori.morimoto.gx@renesas.com>
	<1286875157.3267.8.camel@odin>
	<w3pocazrc1b.wl%kuninori.morimoto.gx@renesas.com>
	<1286876467.3267.30.camel@odin>
	<w3pmxqjr9vz.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 51F65103C3D
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 12:06:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3pmxqjr9vz.wl%kuninori.morimoto.gx@renesas.com>
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

On Tue, Oct 12, 2010 at 07:19:28PM +0900, Kuninori Morimoto wrote:
> Current FSI driver had not cared about simultaneous
> playback/capture on same port.
> This patch add new fsi_stream struct to care it,
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Applied, thanks.
