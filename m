From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [RFC-PATCH 0/2] ASoC: simple_card: support for
 hw-params rules
Date: Mon, 23 May 2016 16:29:04 -0500
Message-ID: <20160523212904.GA6688@rob-hp-laptop>
References: <1463747445-14167-1-git-send-email-kernel@martin.sperl.org>
 <573F6279.8040008@metafoo.de>
 <20160523165931.GY8206@sirena.org.uk>
 <20160523171515.GI4976@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160523171515.GI4976@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 23, 2016 at 06:15:16PM +0100, Mark Rutland wrote:
> On Mon, May 23, 2016 at 05:59:31PM +0100, Mark Brown wrote:
> > On Fri, May 20, 2016 at 09:16:09PM +0200, Lars-Peter Clausen wrote:
> > 
> > > How about allowing to embed eBPF bytecode in the DT that can be installed as
> > > a constraint set? This would allow maximum for flexibility and also make the
> > > implementation a lot easier.
> > 
> > That seems somewhat Linux specific, I'd like to see some DT maintainer
> > buy in on that one as well as Takashi's thoughts.
> 
> I am very much not in favour of embedding eBPF bytecode into the DT.

+1 What's wrong with Forth? ;)

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
