From: Justin Cormack <justin@street-vision.com>
Subject: Re: hdsp driver status
Date: 03 Jul 2003 18:08:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1057252106.7192.61.camel@lotte>
References: <32847.81.50.18.84.1057230774.squirrel@www.undata.org>
	<3F044FF5.2010602@boosthardware.com>  <3F0456A5.9000600@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F0456A5.9000600@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Thomas Charbonnel <thomas@undata.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2003-07-03 at 17:15, Patrick Shirkey wrote:
> Patrick Shirkey wrote:
> > Thomas Charbonnel wrote:
> > 
> >>
> >> Remaining:
> >> * HDSP9652: the matrix mixer isn't yet handled right.
> >> * Rev11 + Multiface: either the firmware file is wrong or the io-box
> >> firmware upload scenario has changed for this card revision. Has anyone
> >> ever had success with this combination (or rev11 + Digiface) ?
> >>

you mean 0xb? I have one that works on 0.9.0rc5, but wont work on
0.9.4/todays cvs.

And now I have a 0xa revision that wont work at all on any version of
the driver...


Justin




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
