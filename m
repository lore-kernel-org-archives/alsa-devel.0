From: Michael Zoran <mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 4/4] dts: bcm283x.dtsi: Add analog audio/headphone jack
 for bcm2835
Date: Tue, 14 Mar 2017 01:47:59 -0700
Message-ID: <1489481279.656.1.camel@crowfest.net>
References: <20170312063820.19313-1-mzoran@crowfest.net>
         <20170312063820.19313-4-mzoran@crowfest.net>
         <a5ae562f-6843-f137-6470-36c53cfd1799@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a5ae562f-6843-f137-6470-36c53cfd1799-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2017-03-14 at 09:05 +0100, Stefan Wahren wrote:

> AFAIK the Raspberry Pi 3 uses pin 40 and 41.
> 

I did all my testing on the RPI 3, so I'm almost certain it's correct. 
It matches with the schematic and it matches with what the downstream
tree uses for the firmware based driver(dummy claiming of pins).
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
