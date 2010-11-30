From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH 4/5] ASoC: Fix missing
	spin_unlock_irqrestore
Date: Tue, 30 Nov 2010 11:13:55 +0000
Message-ID: <20101130111354.GC7403@rakim.wolfsonmicro.main>
References: <1291023491.22911.1.camel@mola> <1291023767.22911.9.camel@mola>
	<20101129114700.GP30360@rakim.wolfsonmicro.main>
	<AANLkTinks9Msj11mfJSO9Ezwt179JYkxNKFD3dAp=X+X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 72C3B103933
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 12:13:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTinks9Msj11mfJSO9Ezwt179JYkxNKFD3dAp=X+X@mail.gmail.com>
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
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 30, 2010 at 09:36:29AM +0800, Wan ZongShun wrote:

> I have tested it.

> Thanks!
> Acked-by: Wan ZongShun <mcuos.com@gmail.com>

Excellent, applied now - thanks to both of you!
