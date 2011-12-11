From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5] ASoC: mxs: Add missing
	MODULE_LICENSE("GPL")
Date: Sun, 11 Dec 2011 10:59:16 +0800
Message-ID: <20111211025915.GD2800@opensource.wolfsonmicro.com>
References: <cover.1323436034.git.LW@KARO-electronics.de>
	<a541450341a475b27ef603c5a4a67f113ba7fa0c.1323436034.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6DEC524954
	for <alsa-devel@alsa-project.org>; Sun, 11 Dec 2011 03:59:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <a541450341a475b27ef603c5a4a67f113ba7fa0c.1323436034.git.LW@KARO-electronics.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: alsa-devel@alsa-project.org, Dong Aisheng-B29396 <B29396@freescale.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 09, 2011 at 02:38:11PM +0100, Lothar Wa=DFmann wrote:
> The sound driver refuses to load as module, because of the missing
> MODULE_LICENSE("GPL").
> The file header indicates that the driver is indeed published under
> the GPL.

Applied, thanks.
