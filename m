From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: trivial: add tfa9879 device
Date: Sun, 3 Dec 2017 19:01:04 -0200
Message-ID: <CAOMZO5Dgr6B19o+1xQJ7Ne8SC7kx90_iecHjD7tZ-GCsSr3JXA@mail.gmail.com>
References: <20171201224425.5477-1-peda@axentia.se> <20171201224425.5477-2-peda@axentia.se>
 <CAOMZO5BA2ZbBnPVORALkEGV21j7H9GJW_2uVvtEEU=8qM599-w@mail.gmail.com>
 <8e295c61-089e-170d-bca2-42ded2021c99@axentia.se> <CAOMZO5AE++an6MnagrWoL4qwkDJaqtg_qJ5UKX3PB7sw1cTeiA@mail.gmail.com>
 <5ec7ae30-eeac-3cf8-15ad-f6c3a110c5d7@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5ec7ae30-eeac-3cf8-15ad-f6c3a110c5d7-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 3, 2017 at 6:53 PM, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org> wrote:

> That's funny, because I get the below on both 4.14 and 4.15-rc1. And I
> expect the same ever since the driver was added some 3 years ago.
>
> $ scripts/get_maintainer.pl your-patch-from[1].diff | grep Peter
> Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org> (maintainer:NXP TFA9879 DRIVER)

You are right.

I tried ./scripts/get_maintainer.pl
Documentation/devicetree/bindings/sound/tfa9879.txt

in 4.15-rc1.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
