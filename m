From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 09/39] firewire-lib: Add sort function for
 transmitted packet
Date: Wed, 12 Mar 2014 10:23:45 +0900
Message-ID: <531FB721.8010507@sakamocchi.jp>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-10-git-send-email-o-takashi@sakamocchi.jp>
 <531CD7F9.1000303@ladisch.de> <531DBE48.7040800@sakamocchi.jp>
 <531EC536.5020201@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id A8C0A261AEC
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 02:23:52 +0100 (CET)
In-Reply-To: <531EC536.5020201@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Clemens,

I have no time to discuss about this issue.
(If it was last November, I could have done it.)

I decide to remove this patch and drop support for Fireworks version 4.8 
or former. I guess a support for some devices are also dropped because 
hardware vendor has never released firmware version 5.0 or later for the 
devices.

For detecting dropped packets, please reply to [05/39] patch.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
