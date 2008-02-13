From: "Daniele (Mastro)" <daniele.bilug@gmail.com>
Subject: Re: Notebook Toshiba satellite x200-21g with realtek
 snd-hda-intel audio device still not supported (codec ALC268)
Date: Wed, 13 Feb 2008 01:32:56 +0100
Message-ID: <47B23AB8.6000301@gmail.com>
References: <47672BCB.9080608@gmail.com>	<476912F3.8090609@gmail.com>	<476A2BCC.4060109@gmail.com>	<s5h1w9h4g5d.wl%tiwai@suse.de>	<47727C6C.6080401@gmail.com>	<1198815321.3732.229.camel@razman.gruemaster.com>	<47B06DEF.4070609@gmail.com>	<s5htzkfv5jp.wl%tiwai@suse.de>	<47B0D319.2000702@gmail.com>
	<s5hd4r2v5g1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by alsa0.perex.cz (Postfix) with ESMTP id D755824458
	for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2008 01:33:00 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id q2so941941uge.50
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 16:33:00 -0800 (PST)
In-Reply-To: <s5hd4r2v5g1.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai ha scritto:
> Basically run alsa-info.sh on your problematic configuration you
> wanted to use.  So, don't pass model option unless you did so in the
> earlier versions and it ran well.  If you have another better-working
> configuration, take alsa-info.sh snapshot as well for comparison.

http://pastebin.ca/901893

this is with "default" configuration... and it's the best one...
has this the things you need?

> Sure, and as I wrote, the modem is a *different* problem from the
> audio problem you are facing.  I'd be intereseted if it's a
> regression.  But in other cases, it'll be likely ignored, as not
> fixable properly right now.

i see...
well i hope it will be supported one day thanks anyway
i wish i could write them myself

-- 
Daniele
