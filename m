From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: latency.c: some feature requests
Date: Mon, 29 Nov 2004 13:23:46 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411291323170.2147@pnote.perex-int.cz>
References: <1101617894.21427.9.camel@krustophenia.net>
 <Pine.LNX.4.58.0411281232540.11615@pnote.perex-int.cz>
 <1101667038.18348.4.camel@krustophenia.net>  <Pine.LNX.4.58.0411281942520.6878@pnote.perex-int.cz>
 <1101677534.18348.84.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1101677534.18348.84.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 28 Nov 2004, Lee Revell wrote:

> It looks like the playback runs 64 frames ahead of the capture.  Do you
> think this would be a problem from the application's perspective?

That's correct - it's the latency.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
