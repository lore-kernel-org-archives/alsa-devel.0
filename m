From: Peter Zubaj <pzubaj@gaya.sk>
Subject: Re: PROBLEM: Probable kernel bug in VT8233 drivers
Date: Thu, 04 Jan 2007 21:16:20 +0100
Message-ID: <1167941780.4321.7.camel@localhost.localdomain>
References: <200701041332.46215.abrahams@acm.org>
	<1167936731.4321.2.camel@localhost.localdomain>
	<200701041421.35153.abrahams@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from arkady.gaya.sk (arkady.gaya.sk [62.168.75.2])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 458C922D
	for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2007 21:14:07 +0100 (MET)
In-Reply-To: <200701041421.35153.abrahams@acm.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: abrahams@acm.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Looks like alsa driver is loaded and it should work.
Is your sound card working. Did you try play something ?

Peter Zubaj

> > Also check /proc/asound/cards file if there is listed your card -
> > sometimes is modem first card.
> 
> the output is
> 
> 0 [V8235          ]: VIA8233 - VIA 8235
>                       VIA 8235 with VIA1612A at 0xdc00, irq 217
> 



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
