From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [2.6 patch] ALSA: misc cleanups
Date: Mon, 06 Dec 2004 13:44:10 -0500
Message-ID: <1102358650.2897.6.camel@krustophenia.net>
References: <20041206001221.GG2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 4B0252FB
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2004 19:44:13 +0100 (MET)
In-Reply-To: <20041206001221.GG2953@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-12-06 at 01:12 +0100, Adrian Bunk wrote:
>   - sound/synth/emux/emux_synth.c: snd_emux_release_voice

Hmm, this should be used.  I will check it out.

>   - sound/synth/emux/soundfont.: snd_soundfont_mem_used

This one should be used also.

Lee





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
