From: ted <ted@2600.COM>
Subject: Re: No sound output on PowerBook Titanium II (TAS3001c)
 - resend (subscribed now)
Date: Wed, 6 Aug 2003 16:22:15 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.NEB.4.44.0308061613140.5288-100000@phalse.2600.com>
References: <Pine.NEB.4.44.0307221221410.2916-100000@phalse.2600.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.NEB.4.44.0307221221410.2916-100000@phalse.2600.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 22 Jul 2003, ted wrote:

> On Tue, 22 Jul 2003, Takashi Iwai wrote:
>
> > > I've been unable to get the latest stable ALSA to produce any sound at
> > > all.  I even tried the "loading+unloading dmasound_pmac first" trick, but
> > > to no avail.  Everything looks fine, but applications using ALSA refuse to
> > > work or crash.  Using OSS emulation appears to work, but there's no sound
> > > output at all (yes, I've tried maxing out the mixer controls).
> > >
> > > Any ideas?
> > >
> > > The kernel driver seems to work pretty well, but it only supports a single
> > > DSP device (which is rather annoying at times, especially since you
> > > apparently need one for even just console beeps).
> > >
> > > System is a PowerBook Titanium II w/ TAS3001c.  Let me know if you need
> > > more info.  Thanks!
> >
> > please tell me the kernel version.  then i can compare the source of
> > dmasound_pmac to fix the alsa code.
>
> I use Ben's stable tree (from http://www.penguinppc.org/dev/kernel.shtml).
> I'd be happy to test any code changes.  Just let me know.  Thanks!

Any luck with this?  If someone could give me a little direction, I'd be
willing to give it a shot myself.  Thanks.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
