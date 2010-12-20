From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: sh: fsi: modify improper dependent
Date: Mon, 20 Dec 2010 09:25:32 +0000
Message-ID: <1292837132.3304.4.camel@odin>
References: <w3p8vzlntmb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 364C3244A7
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 10:25:35 +0100 (CET)
Received: by wyi11 with SMTP id 11so2575735wyi.38
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 01:25:35 -0800 (PST)
In-Reply-To: <w3p8vzlntmb.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-12-20 at 10:03 +0900, Kuninori Morimoto wrote:
> FSI-AK4642 and FSI-DA7210 are depend on I2C, not I2C_SH_MOBILE
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> This is v2 of
> "ASoC: sh: fsi: remove unnecessary dependent from Kconfig"
> Thanks Mark !!
> 
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
