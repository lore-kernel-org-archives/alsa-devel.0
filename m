From: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 5/5] ASoC: fsl-sai: rename big_endian_data to
 is_msb_first.
Date: Sun, 24 Aug 2014 20:18:11 -0700
Message-ID: <20140825031810.GA30314@Alpha>
References: <1408421693-9929-1-git-send-email-Li.Xiubo@freescale.com>
 <1408421693-9929-6-git-send-email-Li.Xiubo@freescale.com>
 <20140825015053.GB26651@Alpha>
 <b938ef9cd0df48e985a91c931f6052e6@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <20140825024307.GA28441@Alpha>
 <21764759b9c447c7a3c6158e3bcfb3e6@BY2PR0301MB0613.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <21764759b9c447c7a3c6158e3bcfb3e6-swgC6WJTr6EbUgZD/0KOGpwN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "timur-N01EOCouUvQ@public.gmane.org" <timur-N01EOCouUvQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 25, 2014 at 03:11:22AM +0000, Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
> > I'm looking forward to your new version. And I give you an extra info
> > about SAI on i.MX. It should be configured as Little Endian and MSB
> > first. So with the current DT binding it doesn't have big_endian*
> > properties. Any replacement for big_endian_data shall be compatible
> > to this case as well as I mentioned in the previous reply.
> > 
> 
> Fine.
> 
> Please wait.
> 
> BYW, how about other four patches of this patch series ? Do you have any 
> Comment here ? 

Not any more. I think you can drop this one from this series
so that the other four can be applied soon :)

Best regards,
Nicolin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
