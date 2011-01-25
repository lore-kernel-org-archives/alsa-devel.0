From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [RFC][PATCH 0/3] ASoC: sh: fsi: sound format
	selection
Date: Tue, 25 Jan 2011 23:44:39 +0900
Message-ID: <20110125144438.GA19428@linux-sh.org>
References: <w3pmxmr13jx.wl%kuninori.morimoto.gx@renesas.com>
	<20110125141144.GF31453@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp
	[124.34.33.190])
	by alsa0.perex.cz (Postfix) with ESMTP id E03AA103971
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 15:44:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110125141144.GF31453@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 25, 2011 at 02:11:44PM +0000, Mark Brown wrote:
> On Mon, Jan 24, 2011 at 10:41:22AM +0900, Kuninori Morimoto wrote:
> 
> > But I'm not sure it is OK for SPDIF.
> > So, I set these patches as [RFC]
> 
> This looks OK for me providing it tests OK - if everyone else is OK with
> it we can just apply?

The architecture bits are largely trivial, so no problem there:

Acked-by: Paul Mundt <lethal@linux-sh.org>
