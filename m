From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: rockchip: i2s: add support for grabbing output
 clock to codec
Date: Tue, 2 Dec 2014 21:18:35 -0800
Message-ID: <CAD=FV=VtYU5Pdz-xvjSdsReyCqMQaMtw=ZXmH4PO5wFnGVPY1g@mail.gmail.com>
References: <1417531766-29669-1-git-send-email-jay.xu@rock-chips.com>
	<1417531977-30094-1-git-send-email-jay.xu@rock-chips.com>
	<CAD=FV=Uwb1NxxCoXHzHu6DJCpnG_HV2RhCr3JaJaXbJja8kd7A@mail.gmail.com>
	<547E616C.1020503@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <547E616C.1020503-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jianqun <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Jianqun Xu <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 2, 2014 at 5:03 PM, Jianqun <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> Hi Doug:
>
> =E5=9C=A8 12/03/2014 01:54 AM, Doug Anderson =E5=86=99=E9=81=93:
>> Jianqun,
>>
>> This ought to be a "v3" patch and ideally ought to describe
>> differences from v2 (after the cut).  Please have Kever or Chris
>> review your next patch before sending it out since I think they are
>> familiar with the process.

You still seem to be missing versions in your subject line and missing
info on what changed version to version.  The latest version you just
sent (v4?) is still missing it.

Unless Mark says so then I don't think you need to spin this series,
but please try to add that in the future.


>> You still forgot the blank line here requested by Heiko.  Please try
>> again.  See <https://patchwork.kernel.org/patch/5334991/>
> Although I thought there needn't a blank ~, I wll add it next patch

That would have been OK, but in that case you should have responded to
Heiko's patch and explained that you weren't taking his feedback (and
why you weren't).

-Doug
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
