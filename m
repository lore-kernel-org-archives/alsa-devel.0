From: Abdelghani Ouchabane <abdelghani@ezono.com>
Subject: Re: "modprobe snd_hda_intel" crashes on my hardware
Date: Wed, 28 Sep 2011 14:22:02 +0200
Message-ID: <4E83116A.7070000@ezono.com>
References: <4E817010.7030607@ezono.com>
	<s5hipodciju.wl%tiwai@suse.de>	<4E82D2C6.9060307@ezono.com>
	<s5hpqikbx42.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ezo.ezono.com (ezo.ezono.com [50.22.105.208])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E6A324423
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 16:22:11 +0200 (CEST)
In-Reply-To: <s5hpqikbx42.wl%tiwai@suse.de>
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


>
> OK, it's good to hear.  So 3.1 kernel is fine as is.  Only 3.0 and
> earlier can get Oops with buggy BIOS setups.
>
> I can easily fix it up, but maybe better first stabilize 3.1 and make
> similar 3.0 stable patch.
>
>
> thanks,
>
> Takashi
>   
Do I need to contact the manufacturer of my board to fix the BIOS as 
well, or it can be fixed by a patch?

Many thanks,
Ghani
