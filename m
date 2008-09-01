From: Jean Delvare <khali@linux-fr.org>
Subject: Re: |PATCH] ASoC: Convert wm8510 to a new-style i2c
	driver
Date: Mon, 1 Sep 2008 11:56:28 +0200
Message-ID: <20080901115628.6c6b655e@hyperion.delvare>
References: <20080901112331.594bb663@hyperion.delvare>
	<20080901092951.GA10555@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id C6A491037F7
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 11:56:35 +0200 (CEST)
In-Reply-To: <20080901092951.GA10555@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Geoffrey Wossum <gwossum@acm.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Sep 2008 10:29:52 +0100, Mark Brown wrote:
> On Mon, Sep 01, 2008 at 11:23:31AM +0200, Jean Delvare wrote:
> > Convert the wm8510 codec driver to the new (standard) device
> > driver binding model.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Geoffrey Wossum <gwossum@acm.org>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> for the codec part.

Thanks for all the reviews Mark :)

-- 
Jean Delvare
