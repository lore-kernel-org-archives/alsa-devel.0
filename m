From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp driver
Date: Mon, 03 Mar 2003 11:11:16 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18psU3-0002VE-00@sc8-sf-list1.sourceforge.net>
References: <s5hlm00igiz.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 28 Feb 2003 16:14:28 +0100."
             <s5hlm00igiz.wl@alsa2.suse.de>
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

>although the former doesn't allocate the buffer in advance by checking
>the pci id, but it will preserve the buffers at alsasound stop or
>restart operations just like the latter does.

so when does it allocate them?


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
