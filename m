From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: OSS driver removal, 3nd round
Date: Tue, 19 Dec 2006 10:44:32 -0500
Message-ID: <C51D50F0-D9DB-464F-9B0B-22516B3DC4B5__33036.9795709432$1166543164$gmane$org@mac.com>
References: <20061219041159.GA6993@stusta.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtpout.mac.com (smtpout.mac.com [17.250.248.181])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CF91E29E
	for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2006 16:44:49 +0100 (MET)
In-Reply-To: <20061219041159.GA6993@stusta.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Adrian Bunk <bunk@stusta.de>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, sailer@ife.ee.ethz.ch
List-Id: alsa-devel@alsa-project.org

On Dec 18, 2006, at 23:11:59, Adrian Bunk wrote:
> 1. ALSA drivers for the same hardware
>
> DMASOUND_PMAC

Acked-By: Kyle Moffett <mrmacman_g4@mac.com>

I don't think I've ever used this sound driver on any of my  
PowerMacs, ranging back to my aged 400MHz box, which is (I believe)  
the only piece of hardware I own which it supports, and the ALSA  
driver plays sound on that system perfectly.  Admittedly the ALSA  
driver's a bit more flaky on my newer G5 and powerbook but I don't  
think the DMASOUND_PMAC driver _ever_ supported those (and I doubt it  
ever will).

Cheers,
Kyle Moffett


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
