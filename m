From: Richard Sailer <rs@tuxedocomputers.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirks for several
 Clevo notebook barebones
Date: Wed, 19 Jun 2019 13:14:57 +0200
Message-ID: <9fc98708-d0c3-27c8-beab-a3f842e0e5d6@tuxedocomputers.com>
References: <20190615034207.22723-1-rs@tuxedocomputers.com>
 <s5h4l4od9b2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CC925F808AF
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 13:14:58 +0200 (CEST)
In-Reply-To: <s5h4l4od9b2.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, jeremy@system76.com
List-Id: alsa-devel@alsa-project.org

> 
> Your sign-off is missing.  Could you resubmit with it?

No problem, will send it this evening or in the next few days.

> 
>> This is strange since the System76 Oryx Pro also seems to be a P960 and
>> P970 barebone, so the original fixup should also not have worked for
>> them. @Jeremy: What's your take on this?
> 
> ... and it's better if this mystery is clarified, too.

Agreed, don't want to break their hardware. Thats why I asked and added
jeremy in the CC. I hope he will answer in the next 1-2 weeks.

> 
> We don't have to list up necessarily the detailed model names here.
> Though, it's OK in this form as it's done concisely.
> 
Okay, good to know for the future.


Thanks,
-- Richard
