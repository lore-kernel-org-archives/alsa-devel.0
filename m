From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/2] ALSA: fireworks/firewire-lib: add
 support for recent firmware quirk
Date: Tue, 11 Aug 2015 20:22:28 +0900
Message-ID: <55C9DAF4.4050906@sakamocchi.jp>
References: <1438734065-5204-1-git-send-email-o-takashi@sakamocchi.jp>
 <55C92933.50207@sakamocchi.jp> <s5hbnee2xz0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 679B426051B
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 13:22:32 +0200 (CEST)
In-Reply-To: <s5hbnee2xz0.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Aug 11 2015 14:30, Takashi Iwai wrote:
>> Currently I'm preparing for the next patchset (Digi00x and TASCAM
>> drivers). As a quick glance, for-next branch in sound.git doesn't still
>> includes these two patches. In this case, which branch should my work
>> reabases to?
> 
> Use for-linus branch for now.

OK. And now you merged the 'for-linus' into 'for-next' in upstream. I
rebase to the latter, as usual.


Thanks

Takashi Sakamoto
