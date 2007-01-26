From: Matthias Koenig <mkoenig@suse.de>
Subject: Re: [PATCH] alsa-driver: portman2x4 code cleanup
Date: Fri, 26 Jan 2007 10:22:29 +0100
Message-ID: <n7xbqkmp2ga.fsf@sor.suse.de>
References: <n7xr6tksauu.fsf@sor.suse.de> <s5hzm88bbqt.wl%tiwai@suse.de>
	<87ejpkjjm5.fsf@zebra.localdomain> <s5hhcugb41m.wl%tiwai@suse.de>
	<s5h1wljb8bz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 105082A0
	for <alsa-devel@alsa-project.org>; Fri, 26 Jan 2007 10:23:54 +0100 (MET)
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 9C9E121981
	for <alsa-devel@alsa-project.org>; Fri, 26 Jan 2007 10:23:40 +0100 (CET)
In-Reply-To: <s5h1wljb8bz.wl%tiwai@suse.de> (Takashi Iwai's message of "Thu,
	25 Jan 2007 13:26:56 +0100")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:
> At Wed, 24 Jan 2007 20:47:17 +0100,
> I wrote:
>> 
>> > > BTW, if the driver works for you, we can move this to alsa-kernel tree
>> > > so that it's merged to the upstream kernel...
>> > 
>> > Great, yes I think it can then be moved to alsa-kernel tree.
>> 
>> OK, I'll work on this tomorrow.
>
> Done.  Check the HG tree later if you have time.
> (I added your name to the author list since the latest driver owes you
>  much :)

Thanks. Tested new tree yesterday and it works fine.

Matthias


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
