From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: usbus428 0.0.7 patch against release alsa-driver 0.9.6
Date: Tue, 12 Aug 2003 20:12:34 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0308122009430.28196-100000@studcom.urz.uni-halle.de>
References: <s5hoeyuj0g1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hoeyuj0g1.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Martin Langer <martin-langer@gmx.de>, Karsten Wiese <annabellesgarden@yahoo.de>, alsa-devel@lists.sourceforge.net, us428@drehmoment.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> * the comments in usbus428.c looks like the GPL/BSD dual license but
>   MODULE_LICENSE() is defined as GPL.  is it correct?

I don't think so. Apparently, the comment was copied from usbmidi.c,
while the MODULE_LICENSE came from another file.


Regards,
Clemens




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
