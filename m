From: Perry Gilfillan <perrye@linuxmail.org>
Subject: Adding a Mute Switch to snd-tvmixer
Date: Mon, 12 Apr 2004 11:05:07 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <407ABE33.8030505@linuxmail.org>
Reply-To: perrye@gilfillan.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,

I've a couple of people using my snd-tvmixer module with success now,
and would appreciate comments/critcism/abuse (any thing is better than
the deathly silence my first announcement yeilded) from people more
experienced than myself.

   snd-tvmixer:  http://www.gilfillan.org/ALSA/

In particular, I'd like to know what I may have missed in getting a Mute
Switch to show up in gnome-alsa-mixer.

It's rather confusing, because gnome-volume-control presents Mute
switches for all the controls, vol, bass, and treb, while
gnome-alsa-mixer presents none.

`amixer controls` does not show 'Master Switch' either.

I have yet to use the ALSA option in xawtv/motv, so at this point I can
say that the OSS emulation works great!!

If snd-tvmixer meets with approval, I'll start work on the snd-tvaudio
module this week :)

Thanks,

Perry
-----
Gilfillan Family: http://www.gilfillan.org/

Projects:
   V3TV: http://www.gilfillan.org/v3tv/
   VPX3224:  http://www.gilfillan.org/vpx3224/
   snd-tvmixer:  http://www.gilfillan.org/ALSA/

Old Santa Fe Depot of Guthrie (wip)




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
