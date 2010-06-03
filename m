From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] AsoC/atmel: patch for the unnecessary
	variable removal
Date: Thu, 3 Jun 2010 17:53:21 +0100
Message-ID: <20100603165321.GE2762@rakim.wolfsonmicro.main>
References: <4C0686BE.8000402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A8CD4103810
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 18:53:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C0686BE.8000402@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 03, 2010 at 12:28:46AM +0800, Wan ZongShun wrote:
> The variable 'periods' of structure 'atmel_runtime_data'
> seems no use in whole atmel alsa driver,so I make a patch
> to remove the unnecessary variable.
> 
> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

Applied, thanks.

ASoC, BTW - not AsoC.
