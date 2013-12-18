From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 07/17] firewire-lib: give syt value to
	handle_out_packet()
Date: Wed, 18 Dec 2013 21:29:38 +0900
Message-ID: <52B19532.8090208@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
 <1385186884-8259-8-git-send-email-o-takashi@sakamocchi.jp>
 <52936C78.1050204@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 988B6261663
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 13:29:43 +0100 (CET)
In-Reply-To: <52936C78.1050204@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens,

(Dec 26 2013 00:27), Clemens Ladisch wrote:
> ... I'll review the other patches later.

If you don't mind, I want to post updateed patches for 
firewire-lib/fireworks/bebob. I didn't post them in one time because 
it's a lot (38 patches). But now they depends each other (firewire-lib 
<-> each driver, asound.h/firewire.h <-> each drivers).

Is it OK?


Regards

Takashi Sakamoto
