From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: RE: Major problem with RME HDSP/Multiface and a 64-bit AMD laptop -- SOLVED!!! (partially)
Date: Sun, 21 Mar 2004 00:08:14 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403210508.i2L58EgU013379@dhin.linuxaudiosystems.com>
References: <20040321024721.EUMC1963.smtp3.fuse.net@64BitBadass>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sat, 20 Mar 2004 21:47:21 EST."
             <20040321024721.EUMC1963.smtp3.fuse.net@64BitBadass>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ivica Ico Bukvic <ico@fuse.net>
Cc: george@synthax.com, support@synthax.de, linux-audio-dev@music.columbia.edu, linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>What I basically did is investigated the current driver in Windoze for the
>carbus and it came up as a "generic cardbus interface." I was by now aware
>that the exact cardbus chipset is/was ENE C1410. So I did some searching on
>the Google for the driver and came up with HP's driver download page for one
>of their laptops (mine is eMachines m6807). So, I said what the heck, at
>this point I just might as well go ahead and try it. So I downloaded the
>driver (link:
>http://h18007.www1.hp.com/support/files/hpcpqnk/us/download/18388.html)
>installed it, it went without a hitch and asked me to reboot. Upon rebooting
>the device manager listed the pcmcia interface as the "ENE C1410 Cardbus
>Interface." So far, so good! Upon reconnecting the RME HDSP and playing the
>sound, the sound was absolutely flawless at 3ms latency!!! Yay!

If I may say so, that is just bloody amazing. Congratulations on
this bit of sleuthing. 

Its too bad that getting this to work under Linux will likely require
a lot more effort on the part of many more people.

--p


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
