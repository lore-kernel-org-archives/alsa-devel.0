From: Daniel Pouzzner <douzzer@mega.nu>
Subject: Re: 192khz working for anyone?  and  RME96 patch broke
Date: Tue, 28 Jan 2003 11:48:49 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301281648.h0SGmnF87404@mail.mega.nu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: torger@ludd.luth.se
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>so you have 
>tested with an old ALSA and the new driver (rme96.c) and that does not 
>work?

Yuppers.  Pinned it down pretty carefully.

>Is it double speed capture from analog, or from digital input you are 
>having problems with?

Analog.  Haven't tested digital for the bug yet.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
