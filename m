From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: possible problems with rc6 aplay
Date: Mon, 16 Dec 2002 21:48:15 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18O7is-0001uf-00@sc8-sf-list1.sourceforge.net>
References: <3DFE5965.90F4A8B7@earthlink.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 16 Dec 2002 16:53:25 CST."
             <3DFE5965.90F4A8B7@earthlink.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: patrick reardon <swpatrick@earthlink.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>yes, thnx, it's much clearer now.  my converter is external with no
>rate switches and from the manual i just discovered it always
>operates at 48000 (Alesis AI-3).  i'm s till uncertain how to change
>the card's configuration though.  "alsactl" doesn't se em to provide
>an obvious way to do this (looking at the man page).  but my
>asound.state file has [ ... ]

what do you want to change it to?

--p


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
