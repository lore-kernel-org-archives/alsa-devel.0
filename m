From: jfm3 <jfm3@ouroboros-complex.org>
Subject: Re: hdsp driver status
Date: 03 Jul 2003 13:23:06 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1057252985.1241.20.camel@localhost.localdomain>
References: <32847.81.50.18.84.1057230774.squirrel@www.undata.org>
	 <3F044FF5.2010602@boosthardware.com>  <3F0456A5.9000600@boosthardware.com>
	 <1057252106.7192.61.camel@lotte>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1057252106.7192.61.camel@lotte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Developer List <alsa-devel@lists.sourceforge.net>
Cc: Patrick Shirkey <pshirkey@boosthardware.com>, Thomas Charbonnel <thomas@undata.org>, Justin Cormack <justin@street-vision.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2003-07-03 at 13:08, Justin Cormack wrote:
> On Thu, 2003-07-03 at 17:15, Patrick Shirkey wrote:
> > Patrick Shirkey wrote:
> > > Thomas Charbonnel wrote:
> > > 
> > >>
> > >> Remaining:
> > >> * HDSP9652: the matrix mixer isn't yet handled right.
> > >> * Rev11 + Multiface: either the firmware file is wrong or the io-box
> > >> firmware upload scenario has changed for this card revision. Has anyone
> > >> ever had success with this combination (or rev11 + Digiface) ?
> > >>
> 
> you mean 0xb? I have one that works on 0.9.0rc5, but wont work on
> 0.9.4/todays cvs.
> 
> And now I have a 0xa revision that wont work at all on any version of
> the driver...

I have an 0xb Multiface. I haven't been able to load the firmware with
0.9.4, either with the PCI or the PCMCIA interface. I have not tried
0.9.0rc5, nor have I tried loading the firmware with windows and warm
booting. Either route is a lot of work. I'd rather see the hardware
documentation and work on the driver source code. Thanks for any help!

-- 
(jfm3  2838 BCBA 93BA 3058 ED95  A42C 37DB 66D1 B43C 9FD0)



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
