From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] dump_audiostreaming_interface(): fix ac-3 decoder
Date: Wed, 16 Jun 2010 14:40:23 -0700
Message-ID: <20100616214023.GB312@kroah.com>
References: <1275403951-16253-1-git-send-email-daniel@caiaq.de>
 <1275403951-16253-2-git-send-email-daniel@caiaq.de>
 <20100601165211.GR2695@buzzloop.caiaq.de>
 <20100601170658.GA24055@kroah.com>
 <20100608081019.GE2695@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100608081019.GE2695-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, t.sailer-aAjG49QhEdKVRmA6MYkXiA@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 08, 2010 at 10:10:19AM +0200, Daniel Mack wrote:
> Hi Greg,
> 
> On Tue, Jun 01, 2010 at 10:06:58AM -0700, Greg KH wrote:
> > On Tue, Jun 01, 2010 at 06:52:12PM +0200, Daniel Mack wrote:
> > > Greg,
> > > 
> > > I believe you're maintaining usb-utils now, right? At least it was
> > > you posting an announcement for a new release the other day.
> > 
> > Yes I am.
> > 
> > > Let me know if I should do anything else to get these patches merged :)
> > 
> > Let me wake up and get a chance to get around to these patches?  :)
> > 
> > I'll get to them in a day or so, they look great to me.
> 
> Just a reminder - could you have a look at them already?
> For easier access, the six patches I sent can now also be pulled from
> 
>   git://github.com/zonque/usbutils.git

I've pulled from this branch now and pushed it all out.  I'll go pick up
some other pending patches and cut a new release.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
