From: "Sommer, Roman" <roman.sommer@fau.de>
Subject: Re: [PATCH 0/3] sound/usb/line6: fix some styling issues
Date: Mon, 18 Jun 2018 13:57:26 +0200
Message-ID: <dfb7ed2f90fb8fbc2164385f7403c8a4@fau.de>
References: <1529317779-15908-1-git-send-email-roman.sommer@fau.de>
 <s5h8t7cz8cm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h8t7cz8cm.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Kees Cook <keescook@chromium.org>, Daniel Graefe <daniel.graefe@fau.de>, Bhumika Goyal <bhumirks@gmail.com>, =?UTF-8?Q?Fabi=C3=A1n_Inostroza?= <soulsonceonfire@gmail.com>, linux-kernel@i4.cs.fau.de, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, =?UTF-8?Q?Hans_P=2E_M=C3=B6ller_Ebner?= <hmoller@uc.cl>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2018-06-18 12:39, Takashi Iwai wrote:
> On Mon, 18 Jun 2018 12:29:36 +0200,
> Roman Sommer wrote:
>> 
>> CC: Jaroslav Kysela <perex@perex.cz>
>> CC: Takashi Iwai <tiwai@suse.com>
>> CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> CC: "Hans P. Möller Ebner" <hmoller@uc.cl>
>> CC: Kees Cook <keescook@chromium.org>
>> CC: Kate Stewart <kstewart@linuxfoundation.org>
>> CC: Thomas Gleixner <tglx@linutronix.de>
>> CC: "Fabián Inostroza" <soulsonceonfire@gmail.com>
>> CC: Bhumika Goyal <bhumirks@gmail.com>
>> CC: Philippe Ombredanne <pombredanne@nexb.com>
>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> CC: alsa-devel@alsa-project.org
>> CC: linux-kernel@vger.kernel.org
>> 
>> 
>> This patchseries addresses some styling issues in sound/usb/line6 
>> found by
>> checkpatch.
> 
> Are you working further on this driver to fix any real bugs (or
> implements something new), or it's an action "just because checkpatch
> tells"?  I'd take such cleanup patches only for the former case.
> 

Hi Takashi,

I do intend to work on a few issues as I have some Line6 USB devices 
that
don't work as expected (or at all).
But for now this is just a cleanup patch and I don't want to promise
anything at this point.
Still my interest to use those devices is a strong
motivator.

I'd be glad if you would consider accepting the patch anyway.


Cheers,
Roman
