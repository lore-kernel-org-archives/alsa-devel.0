From: fmoraes74@netzero.net
Subject: Re: Emu10k1x driver
Date: Wed, 12 May 2004 18:36:56 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040512.113705.22943.175177@webmail25.nyc.untd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: fmoraes74@netzero.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> nice, i'll add this to alsa-driver tree.
> i guess pci/emu10k1 is the best location.

That's fine. I had it under pci on my system just because it was easier.

> would you mind to change the indentation level to 8, as described in
Documentation/CodingStyle?
> kernel people prefer to have the codes with the same style.

No problem but I won't be able to do that for a couple of days now. If someone wants to reformat the code, feel free to do it, as I haven't changed anything.

> alsaplayer didn't work, not sure why. I've also tested with the pcm
> test in alsa-lib which seems to be jumping, so that's another
> problem. 

Any ideas/suggestions on the alsaplayer? I will test it more once I have time, but it bothered me that it didn't work with my driver.

Regards,

Francisco

________________________________________________________________
The best thing to hit the Internet in years - NetZero HiSpeed!
Surf the Web up to FIVE TIMES FASTER!
Only $14.95/ month -visit www.netzero.com to sign up today!


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
