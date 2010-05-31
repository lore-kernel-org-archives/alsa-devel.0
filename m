From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: spdif: Add codec driver to use spdif
	stand-alone
Date: Mon, 31 May 2010 12:23:42 +0100
Message-ID: <20100531112342.GJ3489@rakim.wolfsonmicro.main>
References: <1274951628-10572-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ADC4D10389F
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 13:23:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1274951628-10572-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: alsa-devel@alsa-project.org, schen@mvista.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, May 27, 2010 at 06:13:48PM +0900, Seungwhan Youn wrote:
> This patch adds spdif dummy codec driver for using spdif-dit as
> a stand-alone. Until this, spdif-dit can be used only with other
> codecs like tlv320aci3x in davinci platform.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>

Applied, thanks.
