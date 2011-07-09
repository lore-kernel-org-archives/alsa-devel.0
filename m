From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/10] ASoc: mxs: add asoc configuration files
Date: Sat, 9 Jul 2011 04:01:32 +0100
Message-ID: <20110709030132.GE26900@sirena.org.uk>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-5-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1310140790-2132-5-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 08, 2011 at 11:59:44PM +0800, Dong Aisheng wrote:
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

*Always* CC maintainers on patches.

> @@ -57,6 +57,7 @@ source "sound/soc/s6000/Kconfig"
>  source "sound/soc/sh/Kconfig"
>  source "sound/soc/tegra/Kconfig"
>  source "sound/soc/txx9/Kconfig"
> +source "sound/soc/mxs/Kconfig"

Keep all these files sorted.  
