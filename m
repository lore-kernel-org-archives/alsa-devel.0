From: David Lloyd <dmlloyd@tds.net>
Subject: Re: User land drivers.
Date: Fri, 3 Sep 2004 13:05:18 -0500 (CDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.60.0409031304560.29636@tomservo.workpc.tds.net>
References: <413456AE.7000007@superbug.demon.co.uk>
 <Pine.LNX.4.58.0409031603060.21405@linux.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mta01.mail.tds.net (mta01.mail.tds.net [216.170.230.81])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B30B72C9
	for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2004 20:03:15 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.58.0409031603060.21405@linux.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 3 Sep 2004, Jaroslav Kysela wrote:

> Actually, I'm thinking to design a loopback soundcard in kernel in 
> conjunction with a daemon with these targets:
>
> 1) creating "virtual" hardware (PCMs, mixers, RawMIDI ports etc.)
> 2) redirect OSS emulation from the kernel space back to user space
> 3) redirect ALSA devices back to user space

I think this is a great idea!

- D


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
