From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Need to know SBLive Chip difference
Date: Tue, 30 Mar 2004 09:26:46 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403300924450.1835@pnote.perex-int.cz>
References: <Sea2-F27skmMvyDRP9E0003cc73@hotmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA05343
	for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2004 09:26:02 +0200
In-Reply-To: <Sea2-F27skmMvyDRP9E0003cc73@hotmail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: guan yim <guanyim@hotmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 30 Mar 2004, guan yim wrote:

> Hi,
> 
> I need to know the difference between SBLive copyrighted in 2003 and 2002. 
> Does Creative need to sign NDA before they can disclose such information? 

Yes and they're not willing to communicate with us. The communication has
always high delays and very low priority on their side.

> This is vital now as you can see the newest  SBLive totally has no sound 
> output with ALSA 1.0.4rc1

I think that connections to input/output slots changed, so it needs 
only some tests/changes in the emufx.c code.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
