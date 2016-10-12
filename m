From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: Jack sensing in snd_usb_audio ?
Date: Wed, 12 Oct 2016 11:29:50 +0200
Message-ID: <1476264590.6699.18.camel@hadess.net>
References: <1476249011.6699.15.camel@hadess.net>
         <cb965f62-8f42-02cf-b0f3-d841ec559782@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cb965f62-8f42-02cf-b0f3-d841ec559782-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Ferreri Tonello <eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2016-10-12 at 11:14 +0200, Felipe Ferreri Tonello wrote:
> 
<snip>
> What you need is PulseAudio server instead. PulseAudio supports this
> via
> kcontrol for quite some time.
> 
> Jack is supposed to be a low-latency audio server for audio
> applications, not for normal desktop usage.

I'm not talking about jackd but about jack sensing.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
