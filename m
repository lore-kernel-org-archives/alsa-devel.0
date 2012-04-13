From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 7
Date: Fri, 13 Apr 2012 22:19:07 +0200
Message-ID: <4F888A3B.3090705@gmail.com>
References: <1334231475-20980-1-git-send-email-zonque@gmail.com>
	<s5hhawoqhc1.wl%tiwai@suse.de> <s5hty0nph7j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id CC27D24152
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Apr 2012 22:19:13 +0200 (CEST)
Received: by bkwj10 with SMTP id j10so2793198bkw.38
	for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2012 13:19:13 -0700 (PDT)
In-Reply-To: <s5hty0nph7j.wl%tiwai@suse.de>
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
Cc: blablack@gmail.com, alsa-devel@alsa-project.org, clemens@ladisch.de, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

On 13.04.2012 21:25, Takashi Iwai wrote:
> At Fri, 13 Apr 2012 08:25:02 +0200,
> Takashi Iwai wrote:
>>
>> At Thu, 12 Apr 2012 13:51:09 +0200,
>> Daniel Mack wrote:
>>>
>>> Here's the 7th iteration of patches that reimplement the streaming logic of
>>> the ALSA USB audio driver.
>>>
>>> There were some bugs reportes by Felix and Grant, which have been resolved.
>>>
>>> More testing is definitely important, but maybe the code will get a wider
>>> test coverage when merged to the development tree?
>>
>> I'm going to merge the patches to sound git tree later today.
> 
> I applied all patches to topic/usb-endpoint branch of sound git tree.
> Then I found a few issues and fixed up in that branch.
> Please check it later.

They all look reasonable to me. Thanks!


Daniel
