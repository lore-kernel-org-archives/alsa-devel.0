From: Richard A Nelson <cowboy@cavein.org>
Subject: Re: 2.6.21-rc6, ASUS M2V 1.01G, ALSA detection/non-support
Date: Sun, 15 Apr 2007 18:23:09 -0700 (PDT)
Message-ID: <alpine.DEB.0.98.0704151821120.12596@hygvzn-guhyr.pnirva.bet>
References: <alpine.DEB.0.98.0704151341250.12045@hygvzn-guhyr.pnirva.bet>
 <46229CF9.3010609@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754262AbXDPBXO@vger.kernel.org>
In-Reply-To: <46229CF9.3010609@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 15 Apr 2007, Jiri Slaby wrote:

> Date: Sun, 15 Apr 2007 23:45:29 +0200
> From: Jiri Slaby <jirislaby@gmail.com>
> To: Richard A Nelson <cowboy@cavein.org>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: 2.6.21-rc6, ASUS M2V 1.01G, ALSA detection/non-support
> 
> Cc: alsa-devel@alsa-project.org
>
> Richard A Nelson napsal(a):
>> My son has an earlier version of the M2V & BIOS (0901) and his gets full
>> 6ch
>> sound.
>>
>> The 1.01G, and related BIOS (1304 or 1701) do not properly handle the
>> onboard sound:
>> hda_codec: Unknown model for ALC660VD/ALC861VD, trying auto-probe from
>> BIOS...
>
> What does your /proc/asound/version say?

Both machines say:
Advanced Linux Sound Architecture Driver Version 1.0.14rc3 (Wed Mar 14 07:25:50 2007 UTC).

The machines are running Debian Sid

-- 
Rick Nelson
Life'll kill ya                         -- Warren Zevon
Then you'll be dead                     -- Life'll kill ya
