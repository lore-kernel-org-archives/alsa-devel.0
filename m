From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [PATCH] Palm interrupt driven touchscreen driver
Date: Thu, 04 Jun 2009 08:20:08 +0100
Message-ID: <4A2775A8.2040604@mnementh.co.uk>
References: <200906032341.03266.marek.vasut@gmail.com>
	<f17812d70906031835u5a650772wedcab94fd6f2ae2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mnementh.co.uk (mail.mnementh.co.uk [173.45.232.4])
	by alsa0.perex.cz (Postfix) with ESMTP id 9948924403
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 09:20:19 +0200 (CEST)
In-Reply-To: <f17812d70906031835u5a650772wedcab94fd6f2ae2d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Eric Miao wrote:

> Mark, the driver looks generic enough to me, is there some specific
> reason this remains named "mainstone-wm97xx.c"?
> 
> I didn't look into the code too much, yet I'm wondering if it's possible
> to come up with a platform_data to cover the difference of boards
> and make this driver generic.

eseries can use this idea IIRC...
