From: Akshay Bhat <akshay.bhat@timesys.com>
Subject: Re: [PATCH] ALSA: usb-audio: Add sample rate inquiry quirk for B850V3
 CP2114
Date: Tue, 30 Aug 2016 11:06:13 -0400
Message-ID: <9d1a15f0-eee9-f022-ff22-804c9d72466b@timesys.com>
References: <1471025327-3529-1-git-send-email-akshay.bhat@timesys.com>
 <CACrMeVBgQS4je7ny_r83Xi-7yX-AzR2YVT_gHyp5U7m2LpFoyA@mail.gmail.com>
 <s5hfupn4q9z.wl-tiwai@suse.de>
 <213c88ea-f178-cd04-35a7-cb1263c993b1@timesys.com>
 <s5h1t174om8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h1t174om8.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, Ken Lin <ken.lin@advantech.com.tw>, alsa-devel@alsa-project.org, guillaume@eulerian.com, denk@post.com, vdronov@redhat.com, linux-kernel@vger.kernel.org, gtmkramer@xs4all.nl
List-Id: alsa-devel@alsa-project.org



On 08/29/2016 10:49 AM, Takashi Iwai wrote:
>
> Gah, then it was a different one.  Obviously I overlooked your patch
> during my vacation.  Will put it to the queue.
>
> But, this message should appear only once in the recent version.  Does
> it still annoy as appearing repeatedly at all...?
>

Hi Takashi,

Thanks for adding it in the queue. You are correct, I believe when we 
last tested it on 4.7 the message appeared once per playback, so the 
commit message might be a bit misleading.

Thanks,
Akshay
