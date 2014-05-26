From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 00/49 v4] Enhancement for support of Firewire devices
Date: Tue, 27 May 2014 07:45:49 +0900
Message-ID: <5383C41D.4020103@sakamocchi.jp>
References: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
	<538185B4.6010909@sakamocchi.jp> <5382FE3B.2010507@ladisch.de>
	<s5hy4xoly1f.wl%tiwai@suse.de> <s5h8upolnof.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h8upolnof.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Iwai-san,

(May 26 2014 21:38), Takashi Iwai wrote:
> Meanwhile I applied the patches to topic/firewire branch and put to my
> build test bot.  I'll merge the branch to for-next tomorrow if no one
> gives objections.

Thanks for your applying this patchset to topic/firewire branch. I
receive some sparse messages from kbuild test backend. There're several
codes which should be fixed, mainly for type conflict.

I want you to apply revised patchset. I've already done most of this
work for revised patchset.

Should I post them as new patchset? Or post new patches to previous
patchset?


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp


------------------------------------------------------------------------------
The best possible search technologies are now affordable for all companies.
Download your FREE open source Enterprise Search Engine today!
Our experts will assist you in its installation for $59/mo, no commitment.
Test it for FREE on our Cloud platform anytime!
http://pubads.g.doubleclick.net/gampad/clk?id=145328191&iu=/4140/ostg.clktrk
