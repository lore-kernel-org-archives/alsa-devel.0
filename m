From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: Fix the incorrect
 referencing of I2SCON register
Date: Fri, 10 Jun 2011 10:54:44 +0100
Message-ID: <20110610095444.GD26436@opensource.wolfsonmicro.com>
References: <1307669814-9375-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5FAEA10382F
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 11:54:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307669814-9375-1-git-send-email-sbkim73@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, jassisinghbrar@gmail.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 10, 2011 at 10:36:54AM +0900, Sangbeom Kim wrote:
> If DMA active status should be checked, I2SCON register should be referenced.
> In this patch, Fix the incorrect referencing of I2SCON register.

Applied, thanks.
