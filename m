From: Daniel Pouzzner <douzzer@mega.nu>
Subject: Re: Waveterminal 192M Envy24HT
Date: Thu, 20 Mar 2003 13:12:04 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303201812.h2KIC4oP063534@mail.mega.nu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: cw@acidtechno.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Unfortunately, the firmware in the Waveterminal 192's has a different
version number (version 220 or somesuch) than that addressed by those
patches (version 1), and the firmware is sufficiently different that
Waveterminals don't work.  You can do amixer stuff, but no actual
sound.  So it's the vendor specific firmware details that are
missing.

>Excuse my ignorance, but do you mean vendor specific details or chipset
>details ? 
>There is a patch for the Envy24HT here, which i just found in the
>archives if its any use.
>
>http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg05500.html


-------------------------------------------------------
This SF.net email is sponsored by: Tablet PC.  
Does your code think in ink? You could win a Tablet PC. 
Get a free Tablet PC hat just for playing. What are you waiting for? 
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
