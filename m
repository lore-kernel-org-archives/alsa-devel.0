From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: oops with current ALSA CVS + gcc3
Date: Wed, 05 Mar 2003 08:23:55 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18qYp7-0004tg-00@sc8-sf-list1.sourceforge.net>
References: <s5hznoadknm.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 05 Mar 2003 14:10:05 +0100."
             <s5hznoadknm.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>did you compile the kernel itself with the same gcc?
>the combination of gcc-2.x and gcc-3.x on the kernel space will likely
>cause oops.

no, i knew about that issue, and thats why i had to recompile
everything. i am tempted to go back to my older ALSA CVS tree (i
tar'ed it before fetching current CVS) and see what happens.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
