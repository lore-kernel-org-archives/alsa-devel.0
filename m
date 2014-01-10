From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH v2 00/13] speakers: Add support for
 capture/playback of PCM/MIDI
Date: Sat, 11 Jan 2014 01:18:15 +0900
Message-ID: <52D01D47.4030004@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
 <52D01586.10806@ladisch.de> <s5hsisvx21s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id EFFC126109F
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 17:18:19 +0100 (CET)
In-Reply-To: <s5hsisvx21s.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Iwai-san,

(Jan 11 2014 00:57), Takashi Iwai wrote:
 > Yeah, module names aren't that important.  And you can put
 > MODULE_ALIAS("snd-firewire-speakers"), if any.

OK. I decide to rename the driver to 'snd-oxfw, and add the alias.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
