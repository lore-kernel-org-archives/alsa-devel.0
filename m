From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: RME HDSP 9632 driver
Date: Mon, 11 Aug 2003 09:54:21 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGKECLCPAB.mknecht@controlnet.com>
References: <200308111157.08772.chris@realcomputerguy.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200308111157.08772.chris@realcomputerguy.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Smith <chris@realcomputerguy.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
> > I've just got an answer from RME. Expect something to test soon :)
>
> Superb!
>
> Thanks.
>
> Chris

Chris,
   You're in great hands. Thomas has managed to get the HDSP 9652 driver
working with the mixer, with only one major problem left as far as I can
see. Routing is working great on my card with hdspmixer, as are faders and
all metering is working. I Can save preset files and they are reloaded upon
reboot, so there's been lots of progress recently. hdspconf also correctly
sets clock sources which is very helpful.

   My problem right now with the HDSP 9652 is that the audio starts fine,
then cuts out completely, then comes back, making the card unusable. I
expect we'll find a solution to this one of these days soon.

   I will be very interested to see if your 9632 has any similar problems or
not.

Best of luck,
Mark




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
