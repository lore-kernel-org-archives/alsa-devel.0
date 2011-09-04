From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] ASoC: codecs: Remove unused mutex
Date: Sun, 4 Sep 2011 22:48:09 +0800
Message-ID: <CAF+7xWn=1M+iGuXVt6cA0j+b4wZNJh+iyE7ChTQf2xaKCqbaMw@mail.gmail.com>
References: <1315140751.8673.1.camel@phoenix> <20110904141015.GB3668@opensource.wolfsonmicro.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110904141015.GB3668@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, Arnaud Patard <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/9/4 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Sun, Sep 04, 2011 at 08:52:31PM +0800, Axel Lin wrote:
>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>> Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> ---
>> =A0sound/soc/codecs/alc5623.c | =A0 =A02 --
>> =A0sound/soc/codecs/wm9090.c =A0| =A0 =A02 --
>
> This has already been done for wm9090, can you resubmit with just the
> alc5623 change please?
>
Ok. A new patch "ASoC: alc5623: Remove unused mutex" is on the way.

Thanks,
Axel
