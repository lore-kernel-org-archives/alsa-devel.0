From: Chip Salzenberg <chip@pobox.com>
Subject: intel8x0: Prospects for working suspend?
Date: Thu, 19 Feb 2004 17:22:41 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040219222241.GB2390@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.topaz.cx (mail@topaz.cx [66.220.6.227])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA11632
	for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2004 23:23:03 +0100
Received: from tytlal.hmsonline.com
	([207.43.94.202] helo=tytlal ident=Debian-exim)
	by mail.perlsupport.com with asmtp (Exim 3.35 #1 (Debian))
	id 1AtwZ8-00051t-00
	for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2004 14:22:42 -0800
Received: from chip by tytlal with local (Exim 4.30)
	id 1AtwZ7-0001gR-6g
	for alsa-devel@alsa-project.org; Thu, 19 Feb 2004 17:22:41 -0500
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for creating a working driver for my hardware, it's marvelous.
However, last I tried to suspend the intel8x0 driver, it didn't work;
I had to unload and reload it.  What are the prospects for working
suspend/resume in the intel8x0 driver?

PS: I think the OSS driver handles it OK....
-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
