From: Flo Gleixner <flo@bier.homeip.net>
Subject: Re: Problem recording with via 8235
Date: Thu, 29 Jul 2004 00:36:09 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.60.0407290033310.26365@octopus.goldach.test>
References: <Pine.LNX.4.60.0407231650160.25456@octopus.goldach.test>
 <Pine.LNX.4.60.0407261942000.26365@octopus.goldach.test> <s5hoem14eyg.wl@alsa2.suse.de>
 <Pine.LNX.4.60.0407271916300.26365@octopus.goldach.test> <s5hk6wo170q.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk6wo170q.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org




>
> I guess you're using an older version of ALSA.

yes, indeed.

>
> Anyway, change 'Input Source Select' to 'Line'.

Hey, that did it! But why did i get a I/O Error in arecord if this is set 
to Mic?

> Also, you can turn 'Mic Boost' switch on.

That made it even better :-)

>
>
> Takashi
>

Thank you Takashi

Flo


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
