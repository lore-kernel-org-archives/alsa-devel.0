From: "Thomas Charbonnel" <thomas@undata.org>
Subject: RE: hdsp driver status
Date: Fri, 4 Jul 2003 03:20:00 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <33235.81.50.18.84.1057281600.squirrel@www.undata.org>
References: <32880.81.50.18.84.1057263758.squirrel@www.undata.org>
        <NDBBLGIKBJENLAMOLFHGKEIDCKAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <NDBBLGIKBJENLAMOLFHGKEIDCKAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mknecht@controlnet.com
Cc: thomas@undata.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> I'm sort of concerned that after 6 months of no mixer on the HDSP 9652,
> the DF/MF mixer will get fixed, and then I'll find out it has nothing to
> do the HDSP 9652 and be let down again.
>

The MF/DF mixer works, but firmware upload to the iobox fails with some
card revision. On the HDSP 9652 no firmware has to be uploaded (hdsploader
is unecessary), but the mixer is broken.

>    Is it one common design, or is the mixer different?

It is one common design BUT the mixer is different...

Thomas





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
