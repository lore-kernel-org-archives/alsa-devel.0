From: Kailang <kailang@realtek.com>
Subject: Re: Change module name for Chrome
Date: Tue, 8 Apr 2014 16:56:05 +0800
Message-ID: <EE48AD9F4AF64147AF266AEADDD36EB9@realtek.com.tw>
References: <2259125E6B6048C7B3DB0DD2F5BBD60D@realtek.com.tw><CAN8ccibu5kUnZoSbYXXZitXABzPA7C2SXvTZYanJoDDbekVCgA@mail.gmail.com><s5hsipqdh4n.wl%tiwai@suse.de><5C8998C298284925B0366DDAC8B6717F@realtek.com.tw><s5hmwfxmt5o.wl%tiwai@suse.de><00A5C335971D4A02A0E52B6C7F5C64CF@realtek.com.tw><s5hy4zhl97y.wl%tiwai@suse.de><11F2A2679416461E8E3E3A151B84C12E@realtek.com.tw><s5hob0cqmkk.wl%tiwai@suse.de><F14645DC77054988BFE9667657F51B9C@realtek.com.tw>
 <s5hk3b0xlje.wl%tiwai@suse.de>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D23A6267473
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 10:56:12 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

git clone git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git 
sound.git

I use upper to download kernel source code.
It only has master branch.
If i run git pull, it couldn't update for-linus branch. Right?
When is the for-linus or for-next will be merged into master?
Thanks

> At Tue, 8 Apr 2014 16:06:22 +0800,
> Kailang wrote:
>>
>>
>> Oh! sorry..
>> Attach again.
>
> Thanks, applied.
>
>
> Takashi
>
>>
>>
>> > At Tue, 8 Apr 2014 15:34:18 +0800,
>> > Kailang wrote:
>> >>
>> >> Hi Takashi,
>> >>
>> >> Chrome OS was use alc283-dac-wcaps module name as default in their
>> >> kernel.
>> >> I was create the change patch for future support.
>> >
>> > You mean "model" name, right?  If so, please correct and resubmit the
>> > patch.
>> >
>> >
>> > thanks,
>> >
>> > Takashi
>> >
>> > ------Please consider the environment before printing this e-mail.
>> [2 0000-change-model-name-for-chrome.patch <application/octet-stream 
>> (quoted-printable)>]
>> 
