From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] remove emu10k1 pops/clicks at the
	beginning and end of playback (fwd)
Date: Fri, 04 Mar 2005 13:17:14 -0500
Message-ID: <1109960235.6442.9.camel@mindpipe>
References: <Pine.LNX.4.58.0503040932460.1739@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id D2F6B197
	for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2005 19:17:19 +0100 (MET)
In-Reply-To: <Pine.LNX.4.58.0503040932460.1739@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-03-04 at 09:33 +0100, Jaroslav Kysela wrote:
> Hi,
> 
> 	could emu10k1 hackers review this patch?
> 

Excellent!  Seems correct to me.  I have experienced the problem too,
and noticed a while back that we didn't clear the cache properly.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
