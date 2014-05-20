From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH v2 0/9] DT instantiation of sound on T5325
Date: Tue, 20 May 2014 23:53:08 +0200
Message-ID: <20140520215308.GD11248@lunn.ch>
References: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
 <20140508173748.GK27377@lunn.ch>
 <20140520214718.GT12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140520214718.GT12304-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 20, 2014 at 10:47:18PM +0100, Mark Brown wrote:
> On Thu, May 08, 2014 at 07:37:48PM +0200, Andrew Lunn wrote:
> 
> > The ARM mvebu maintainer is happy with these patches. Does anybody
> > have any comments on the sound/soc parts? Mark, will you take the
> > alc5623 and simple-card patches?
> 
> Are there dependencies here?  If not then yes.

Hi Mark

No compile time dependencies.

   Andrew
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
