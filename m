From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 1/4] ASoC: wm8804: Add support for hardware reset line
Date: Tue, 7 Apr 2015 11:50:28 +0100
Message-ID: <20150407105028.GE5442@opensource.wolfsonmicro.com>
References: <1428402810-11729-1-git-send-email-ckeepax@opensource.wolfsonmicro.com> <20150407104720.GD6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150407104720.GD6023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, info-Ht5PubfIbSajfpyLsbbDOw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 07, 2015 at 11:47:20AM +0100, Mark Brown wrote:
> On Tue, Apr 07, 2015 at 11:33:27AM +0100, Charles Keepax wrote:
> > It is best to use the physical reset if it is available. This patch adds
> > support for a GPIO controlled physical reset for the chip.
> 
> You appear to have just sent me two different versions of this series
> (possibly, there's some versioning on one patch in the middle?) - what's
> going on there, what are the differences?

Very sorry, I forgot to CC Sapthagiri again on the first round
that is the only difference.

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
