From: Philippe =?ISO-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Subject: Re: [PATCH v5 2/8] ASoC: imx: merge sound/soc/imx into
	sound/soc/fsl
Date: Tue, 27 Mar 2012 17:06:36 +0200
Message-ID: <2976261.6mYHfHvpym@laptop>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
	<1331888204-27058-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.epfl.ch (smtp4.epfl.ch [128.178.224.218])
	by alsa0.perex.cz (Postfix) with SMTP id B134B103E7F
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Mar 2012 17:06:45 +0200 (CEST)
In-Reply-To: <1331888204-27058-3-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Le vendredi 16 mars 2012 16:56:38 Shawn Guo a =E9crit :
> Freescale PowerPC and ARM/IMX families share the same SSI IP block.
> The patch merges sound/soc/imx into sound/soc/fsl, so that the possible
> code sharing and consolidation can happen.
> =

> This is a plain merge, except that menuconfig SND_POWERPC_SOC is added
> in Kconfig for PowerPC platform as a correspondence to SND_IMX_SOC for
> IMX platform.
> =

> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

This patch has been merged ? If yes in which tree is it available ? =


Thanks,

Philippe
