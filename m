From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp9652 note
Date: Mon, 03 Mar 2003 22:22:33 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18q2xV-0006Jv-00@sc8-sf-list1.sourceforge.net>
References: <20030303204249.3b3d0b0f.m.ash@gmx.at>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 03 Mar 2003 20:42:49 +0100."
             <20030303204249.3b3d0b0f.m.ash@gmx.at>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: m <m.ash@gmx.at>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I tried a hdsp9652 install this weekend and found out I had to add another cas
>e line to get it recognised at all (instead of downgrading firmware).
>
>this seems to work for now ( although the driver claims that 
>ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:2935: I/O Box is a Digiface )

i've already added this to my upcoming patch.

its a new h/w rev-level for the hdsp9652.

--p


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
