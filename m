From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: sb16 gets wedged when doing overlapped i/o (full duplex)
Date: Thu, 05 Dec 2002 10:23:08 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18Jxl6-0008VG-00@sc8-sf-list1.sourceforge.net>
References: <3DEF5865.7060109@monmouth.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 05 Dec 2002 08:45:09 EST."
             <3DEF5865.7060109@monmouth.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "John S. Denker" <jsd@monmouth.com>
Cc: Uros Bizjak <uros@kss-loka.si>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> From the keen-grasp-of-the-obvious department:
>This project would be a lot better off if there were
>better documentation, and (some) comments in the code.
>Why write the code if it's not going to be used?
>If it's not documented, it's not going to be used!

actually, i have to note that this is not so obvious. there are *many*
people using ALSA. we've all sworn our way through the process. 

there is *no* point in reminding this list about the need for
documentation. the current state is pitiful, though just barely
adequate to get people started. many folks seem to think there is a
large group of people working on ALSA: there is not. it consists at
this time of just jaroslav and takashi as "full time" people, clemens
doing a fabulous job with some deep patch work, and then a few others
like myself dropping by with driver patches and occasionally new
patches. at this point hardly any of the linux-sound crew that has
held together the kernel's OSS-derived system have switched to working
on ALSA. patrick has done a great job improving what's on the website,
but there is still a long way to go. he has set up a system where you
can add to the per-card documentation yourself, which is a good place
to begin.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
