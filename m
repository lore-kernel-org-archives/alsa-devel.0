From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: 2.6.10: i810 more AC97 tunings
Date: Mon, 27 Dec 2004 14:18:01 +0000
Message-ID: <1104157078.20952.27.camel@localhost.localdomain>
References: <1104104497.16487.12.camel@localhost.localdomain>
	 <s5hpt0vde7j.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 14A96212
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2004 16:21:55 +0100 (MET)
Received: from localhost.localdomain (unknown [81.2.110.250])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 91D2A3FF98
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2004 16:21:54 +0100 (MET)
In-Reply-To: <s5hpt0vde7j.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: torvalds@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Llu, 2004-12-27 at 14:10, Takashi Iwai wrote:
> At Sun, 26 Dec 2004 23:41:38 +0000,
> Alan Cox wrote:
> > 
> > Add some more funky AC97 knowledge to the intel8x0 driver. These come
> > from Red Hat and its partners and are included in our shipping code.
> 
> These entries seem to be already included in 2.6.10.
> Note that the quirk list is sorted in the order of vendor id.


Thanks. Will double check and drop.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
