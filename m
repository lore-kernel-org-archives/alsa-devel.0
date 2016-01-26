From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ASoC: fsl: add imx-cs427x machine driver
Date: Tue, 26 Jan 2016 07:47:28 -0200
Message-ID: <CAOMZO5BjeDMqNgf-=tE7=pByJi+jJVA=G2bbtp+XJeYbpev6KA@mail.gmail.com>
References: <1453744403-12268-1-git-send-email-eu@felipetonello.com>
	<20160126022948.GA21187@rob-hp-laptop>
	<56A73FDE.2060607@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56A73FDE.2060607-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Ferreri Tonello <eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Felipe,

On Tue, Jan 26, 2016 at 7:43 AM, Felipe Ferreri Tonello
<eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org> wrote:

> I agree, but that how it is today. These platform drivers for imx are
> similar but not identical. Looking at them I would guess that they have
> 50 to 60% of duplicated code.

Would simple-audio-card or fsl-asoc-card help in this case?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
