From: Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>
Subject: Re: [alsa-devel] [PATCH 0/9] dw-hdmi audio support
Date: Tue, 5 Jan 2016 16:40:54 +0100
Message-ID: <CAH-u=810V863yYhMvvtaQ7jxNgrOXAL4bi1mS506a-yOTbuYhQ@mail.gmail.com>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk> <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <1440664941.3233.38.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440664941.3233.38.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Airlie <airlied@linux.ie>, Jon Nettleton <jon.nettleton@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, linux-rockchip@lists.infradead.org, Yakir Yang <ykk@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Russell,

2015-08-27 10:42 GMT+02:00 Philipp Zabel <p.zabel@pengutronix.de>:
>
> Am Samstag, den 08.08.2015, 17:09 +0100 schrieb Russell King - ARM
> Linux:
> > Following on from the previous sub-series, this sub-series adds audio
> > support to dw-hdmi.
> >
> > The two different variants are now in this patch: AHB audio support
> > found on iMX6 platforms, and I2S support found on Rockchip patches.
> > Thanks to Yakir Yang for contributing the I2S support.
> >
> > I suspect that there is still some discussion to be had on this
> > series, though I would like to see it moving forward so that we can
> > get something merged.
>
> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> on i.MX6 GK802 via HDMI connected to a TV (stereo only).
>
> except for the i2s patch, which is broken in this series.
>
> regards
> Philipp


What is the status of this series ?
I would like to use audio output in HDMI on my i.MX6 board, but I
don't know if you have some pending WIP on this ?

Thanks,
JM
