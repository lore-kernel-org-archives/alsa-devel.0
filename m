From: Mark Knecht <markknecht@comcast.net>
Subject: Re: RME HDSP 9632 driver
Date: 11 Aug 2003 12:50:29 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1060631428.2428.4.camel@Wizard.knechthome.com>
References: Your message of "Mon, 11 Aug 2003 20:50:14 +0200." <200308111853.h7BIrZ6k021223@localhost.localdomain>
	 <32946.81.53.22.205.1060630037.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <32946.81.53.22.205.1060630037.squirrel@www.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: Paul Davis <paul@linuxaudiosystems.com>, chris@realcomputerguy.com, mknecht@controlnet.com, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2003-08-11 at 12:27, Thomas Charbonnel wrote:
> >
> > i don't have it, matthias just told me he'd be happy to tell us. the one
> > problem is that you *must* test this on an hdsp9652. if you get it
> > wrong, and are using it on an hdsp system, you will make the hardware
> > unusable. the hdsp9652 has some method for resetting the firmware back
> > to the factory defaults. if you need an hdsp9652, i can send you mine,
> > or i and/or mark can test.
> >
> 
> Ok, I'll ask him. As I'm getting used to remote testing, I don't think it
> is necessary to send me your card. This way I keep a chance to kindly
> bother you asking you to test multicard support in hdspconf and hdspmixer
> :)
> 
Thomas and Paul,
   I'd be happy to test it, but the language above is a bit scary. If
the firmware upgrade program messes up my card, are we guaranteed that
the Windows version will fix it, or the onboard secondary firmware will
take over?

   If Matthias is confident that we will not destroy the card I'm happy
to help, although I must say I'm not sure this is the most important
issue right now, is it? Why do I need the firmware upgrader if the
driver for the HDSP 9652 card doesn't work? Or is this just so other
users with a DigiFace or a MultiFace can change their firmware? ;-)

   Anyway, with a little bit of concern I will be happy to help in this
area also.

Cheers,
Mark



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
