From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v2 02/12] ASoC: sun8i-codec-analog: split
 out line in
Date: Mon, 6 Mar 2017 11:45:39 +0800
Message-ID: <CAGb2v66MKJ003hn8U0Y=O77gzAPLN-1vOfF3XOP9TdFJpageOQ@mail.gmail.com>
References: <20170305133709.6288-1-icenowy@aosc.xyz> <20170305133709.6288-3-icenowy@aosc.xyz>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBB65W6PCQKGQEBZYH7UA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170305133709.6288-3-icenowy-ymACFijhrKM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 5, 2017 at 9:36 PM, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org> wrote:
> Allwinner V3s features an analog codec without LINEIN.
>
> Split out this part, in order to prepare for the V3s analog codec.
>
> Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>

Acked-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
