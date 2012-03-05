From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 01/17] ASoC: imx: move eukrea audmux
 call into ASoC machine driver
Date: Tue, 6 Mar 2012 07:45:33 +0800
Message-ID: <20120305234531.GJ16232@S2101-09.ap.freescale.net>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-2-git-send-email-shawn.guo@linaro.org>
	<20120305174612.GY3224@opensource.wolfsonmicro.com>
	<20120305192759.GB3852@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C200E2417D
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 00:31:03 +0100 (CET)
Received: by iakh37 with SMTP id h37so6623750iak.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Mar 2012 15:31:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120305192759.GB3852@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 05, 2012 at 08:27:59PM +0100, Sascha Hauer wrote:
...
> For patches 01-08 I can give my:
> 
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The rest I would like to test. Shawn, on what is this series based? It
> neither applies on v3.3-rc6 nor on arm-soc/for-next.
> 
As I intend to have the series go through Mark's tree, I based it on
sound/for-next.

-- 
Regards,
Shawn
