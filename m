From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Blackfin: allow SPI for SSM2602 parts
Date: Fri, 17 Jun 2011 09:04:17 +0100
Message-ID: <4DFB0A81.9020605@ti.com>
References: <1308277455-370-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 5366F2445E
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 10:04:31 +0200 (CEST)
In-Reply-To: <1308277455-370-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 17/06/11 03:24, Mike Frysinger wrote:
> This board has hardware switches for selecting SPI or I2C, so don't
> require I2C for this driver.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>
