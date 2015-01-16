From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: ESI Juli@ crash with external clock switch - patch
Date: Fri, 16 Jan 2015 21:53:37 +0100
Message-ID: <54B97A51.60009@ivitera.com>
References: <54B28174.7060008@ivitera.com> <s5hwq4t2u33.wl-tiwai@suse.de>
 <54B2B992.7000909@ivitera.com> <s5hegr12gxn.wl-tiwai@suse.de>
 <54B2E48B.7020000@ivitera.com> <s5hvbkc1kaa.wl-tiwai@suse.de>
 <54B3872C.2010501@ivitera.com> <s5hwq4sm2bs.wl-tiwai@suse.de>
 <54B82E02.3080008@ivitera.com> <s5ha91isl7e.wl-tiwai@suse.de>
 <54B9763A.8030405@ivitera.com> <s5ha91izchf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id E2698260427
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 21:53:42 +0100 (CET)
In-Reply-To: <s5ha91izchf.wl-tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 16.1.2015 v 21:39 Takashi Iwai napsal(a):
> At Fri, 16 Jan 2015 21:36:10 +0100,
>
> There should be no change regarding quartet, also about PM.
> The patches doesn't add the PM support to quartet, but rather
> robustify only the PM of Juli@ (and ak4113/4114 codec side support).
>
> In anyway, I'm going to merge them once when you confirm them
> working.

OK, I will do so.

Thanks,

Pavel.
