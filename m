From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [RFC][PATCH 4/5] ASoC: Fix missing spin_unlock_irqrestore
Date: Tue, 30 Nov 2010 09:36:29 +0800
Message-ID: <AANLkTinks9Msj11mfJSO9Ezwt179JYkxNKFD3dAp=X+X@mail.gmail.com>
References: <1291023491.22911.1.camel@mola>
	<1291023767.22911.9.camel@mola>
	<20101129114700.GP30360@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101129114700.GP30360@rakim.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/11/29 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, Nov 29, 2010 at 05:42:47PM +0800, Axel Lin wrote:
>
>> I don't have this hardware handy, could you help to test this patch
>> if you think this patch is ok.
>
> I've applied everything except this one - Wan, can you let us know how
> the testing goes please?
>

Hi all,

I have tested it.

Thanks!
Acked-by: Wan ZongShun <mcuos.com@gmail.com>


-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel@lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900@googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com@gmail.com
