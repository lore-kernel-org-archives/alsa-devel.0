From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: RME HDSP 9632 driver
Date: Mon, 11 Aug 2003 15:57:08 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308111957.h7BJv8a9025850@localhost.localdomain>
References: <1060631428.2428.4.camel@Wizard.knechthome.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "11 Aug 2003 12:50:29 PDT."
             <1060631428.2428.4.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@comcast.net>
Cc: Thomas Charbonnel <thomas@undata.org>, chris@realcomputerguy.com, mknecht@controlnet.com, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>   I'd be happy to test it, but the language above is a bit scary. If
>the firmware upgrade program messes up my card, are we guaranteed that
>the Windows version will fix it, or the onboard secondary firmware will
>take over?

i think its more like a jumper setting or something like that. i never
checked in with matthias because i never got close to writing the
utility. but i do know that on the hdsp952, there are no problems if
its goes wrong (they had to write it for windows too, remember? :))

>   If Matthias is confident that we will not destroy the card I'm happy
>to help, although I must say I'm not sure this is the most important
>issue right now, is it? Why do I need the firmware upgrader if the
>driver for the HDSP 9652 card doesn't work? Or is this just so other
>users with a DigiFace or a MultiFace can change their firmware? ;-)

its mostly for them. the hdsp9652 doesn't really need f/w upgrades to
remain in sync with i/o configuration files, since there aren't any of
the latter.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
