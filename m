From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 07/17] firewire-lib: give syt value to
	handle_out_packet()
Date: Wed, 18 Dec 2013 18:26:01 +0100
Message-ID: <52B1DAA9.3070806@ladisch.de>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
 <1385186884-8259-8-git-send-email-o-takashi@sakamocchi.jp>
 <52936C78.1050204@ladisch.de> <52B19532.8090208@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 7F877261683
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 18:27:03 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id AE9072102C
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 12:27:02 -0500 (EST)
In-Reply-To: <52B19532.8090208@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> (Dec 26 2013 00:27), Clemens Ladisch wrote:
>> ... I'll review the other patches later.
>
> If you don't mind, I want to post updateed patches for firewire-lib/fireworks/bebob.
> I didn't post them in one time because it's a lot (38 patches). But now they depends
> each other (firewire-lib <-> each driver, asound.h/firewire.h <-> each drivers).
>
> Is it OK?

Yes; go ahead.


Regards,
Clemens
