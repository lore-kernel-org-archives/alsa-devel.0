From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v4] ASoC: imx-wm8962: Remove machine driver
Date: Tue, 27 Feb 2018 08:24:44 +0000
Message-ID: <1519719884.13463.112.camel@nxp.com>
References: <1519694689-15370-1-git-send-email-festevam@gmail.com>
 <20180227012820.GA6647@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00067.outbound.protection.outlook.com [40.107.0.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 83372267B0E
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 09:24:47 +0100 (CET)
In-Reply-To: <20180227012820.GA6647@Asurada-Nvidia>
Content-Language: en-US
Content-ID: <194923125A658E4C877A31BFCF09C5F7@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "festevam@gmail.com" <festevam@gmail.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>, Leonard Crestez <leonard.crestez@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Lu, 2018-02-26 at 17:28 -0800, Nicolin Chen wrote:
> On Mon, Feb 26, 2018 at 10:24:49PM -0300, Fabio Estevam wrote:
> > 
> > From: Fabio Estevam <fabio.estevam@nxp.com>
> > 
> > fsl-asoc-card machine driver also handles wm8962, so there is
> > really no need for keeping the dedicated imx-wm8962 driver anymore.
> > 
> > Remove the imx-wm8962 machine driver.
> > 
> > Suggested-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
