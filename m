From: Kailang <kailang@realtek.com>
Subject: Re: Enable more HP machine to enable mute led
Date: Fri, 13 Jun 2014 17:56:01 +0800
Message-ID: <E0BCED37B0144C23A4EAB02AC7900C61@realtek.com.tw>
References: <AD477C06ADA84EB4A008D8EF0A900D8F@realtek.com.tw>
 <s5h8up1gn9l.wl%tiwai@suse.de>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FDF2261A3D
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 11:55:50 +0200 (CEST)
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

> At Fri, 13 Jun 2014 17:27:31 +0800,
> Kailang wrote:
>> 
>>  Hi Takashi,
>>  
>> Add more HP machine to support mute led functions.
> 
> Applied this now as is.  But, the table looks bigger and bigger, which
> I don't like any more.
> 
> So, all these devices have no indication of mute LED in any DMI or
> whatever entries?  In the past, most of HP machines had a DMI string
> showing the mute LED capability.
> 

I will trace this.
But as i know, there are no DMI entries for realtek case.
I don't like to add this, too. ^^

Thanks a lot.

> 
> thanks,
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
