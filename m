From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [ALSA - lib 0000508]: JACK connecting to SPDIF failes!
Date: Mon, 20 Sep 2004 09:01:50 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409201301.i8KD1oDQ006459@localhost.localdomain>
References: <20040920120540.883E54904C@server.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from out006.verizon.net (out006pub.verizon.net [206.46.170.106])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 58BDB2EE
	for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2004 15:01:52 +0200 (MEST)
In-reply-to: Your message of "Mon, 20 Sep 2004 14:05:40 +0200."
             <20040920120540.883E54904C@server.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: bugtrack@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm not in ALSA mantis yet, but I will just note this:

>ALSA lib pcm_hw.c:1155:(snd_pcm_hw_open) open /dev/snd/pcmC0D2c failed: No
>such file or directory
>
>One might think about making jackd's error message a little more verbose
>though. This one is confusing new users. But this should rather be
>discussed on the jackit-devel mailing list..

it has already been improved in the latest JACK release (0.99.0)

--p


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
