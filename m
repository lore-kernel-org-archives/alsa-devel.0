From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 2/2] ASoC: Add adau* drivers to the Analog
 Devices file patterns
Date: Fri, 17 Jun 2011 16:48:28 +0100
Message-ID: <4DFB774C.3050106@ti.com>
References: <1308306271-28411-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1308306271-28411-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id AE92F245E3
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 17:48:41 +0200 (CEST)
In-Reply-To: <1308306271-28411-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mike Frysinger <vapier@gentoo.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 17/06/11 11:24, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  MAINTAINERS |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7da0089..ecc44e6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -533,6 +533,7 @@ L:	device-drivers-devel@blackfin.uclinux.org
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>  W:	http://wiki.analog.com/
>  S:	Supported
> +F:	sound/soc/codecs/adau*
>  F:	sound/soc/codecs/ad1*
>  F:	sound/soc/codecs/ssm*
>  

Acked-by: Liam Girdwood <lrg@ti.com>
