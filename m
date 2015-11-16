From: Cheah Kok Cheong <thrust73@gmail.com>
Subject: Re: [PATCH] Sound: Usb: Misc: ua101: replace le16_to_cpu() with
 usb_endpoint_maxp()
Date: Tue, 17 Nov 2015 04:39:14 +0800
Message-ID: <20151116203914.GA2270@gmail.com>
References: <1447536690-25173-1-git-send-email-thrust73@gmail.com>
 <56488E94.1030609@ladisch.de>
 <s5h1tbqfk0d.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h1tbqfk0d.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 16, 2015 at 09:04:02AM +0100, Takashi Iwai wrote:
> On Sun, 15 Nov 2015 14:54:28 +0100,
> Clemens Ladisch wrote:
> > 
> > Cheah Kok Cheong wrote:
> > > Commit 939f325f4a0f ("usb: add usb_endpoint_maxp() macro")
> > >
> > > And commit 29cc88979a88 ("USB: use usb_endpoint_maxp()
> > > instead of le16_to_cpu()")
> > 
> > These sentences no verb.
> > 
> > > Patched against
> > > git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> > 
> > This does not belong into the commit message.
> > 
> > > Signed-off-by: Cheah Kok Cheong <thrust73@gmail.com>
> > 
> > Otherwise:
> > Acked-by: Clemens Ladisch <clemens@ladisch.de>
> 
> Applied now with some manual fixes.
> 
> 
> thanks,
> 
> Takashi
> 
Sorry for the commit message mistakes. Will keep in mind.
Thank you all.
Brgds,
CheahKC 
