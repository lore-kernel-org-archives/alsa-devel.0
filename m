From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problem with arecord on Audigy 2 NX
Date: Tue, 30 Mar 2004 09:08:27 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403300907530.1835@pnote.perex-int.cz>
References: <4064B687.C88E8575@cs.berkeley.edu> <Pine.LNX.4.58.0403271339440.1836@pnote.perex-int.cz>
 <4068ABD0.18FCFB1F@cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4068ABD0.18FCFB1F@cs.berkeley.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Yitao Duan <duan@cs.berkeley.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 29 Mar 2004, Yitao Duan wrote:

> Thanks for the info, Jaroslav. I upgraded all of the lib, driver, tools, and
> utils to 1.0.4rc1. But I got the same results: linux rec command worked fine
> but arecord caused Segmentation fault after readi_func was called 3 times
> (aplay also worked alright). Any idea what can be happening? Or is there
> anybody using the same card (Audigy 2 NX) without problem?

Could you send me 'arecord -v' output?

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
