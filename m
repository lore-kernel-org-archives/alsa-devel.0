From: Olaf Hering <olh@suse.de>
Subject: snd-powermac produces only low quality dirty sound
Date: Tue, 14 Dec 2004 22:35:49 +0100
Message-ID: <20041214213549.GA22308@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 39C2F1E0
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2004 22:35:50 +0100 (MET)
Received: from hermes.suse.de (hermes-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id D9ED5121911E
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2004 22:35:49 +0100 (CET)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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


All 2.6 versions I tried so far produce only "dirty" low quality sound
when playing mp3 with xmms with either the alsa or oss plugin.
But it works as expected when I use dmasound_pmac and the liboss plugin.

Any ideas how to debug it?
I "see" it on an ibook 600MHz, but also on a G4 and a 400MHz Powerbook.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
