From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] Adds 24bit, 96khz support for multichannel
 playback on the Audigy 2 sound cards.
Date: Sun, 13 Mar 2005 09:07:24 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0503130906540.1755@pnote.perex-int.cz>
References: <423349A5.8020001@superbug.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 34EF71BD
	for <alsa-devel@alsa-project.org>; Sun, 13 Mar 2005 09:20:23 +0100 (MET)
In-Reply-To: <423349A5.8020001@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 12 Mar 2005, James Courtier-Dutton wrote:

> Please see readme.txt at 
> http://www.alsa-project.org/~james/alsa-driver/p16v/
> http://www.alsa-project.org/~james/alsa-driver/p16v/readme.txt
> 
> It works with the current alsa CVS.
> I would like this to be merged with the CVS quite soon if possible.

Could you cleanup a bit your code before merging? It seems that there is 
alot of #if 0 .. #endif parts....

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
