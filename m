From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 15/21] ALSA: oxygen: use match_string() helper
Date: Thu, 31 May 2018 21:40:28 +0300
Message-ID: <CAHp75VdDQXkBUb8Vgiaof68hrO94nnT7L_kLN9UscgUJDrza+g@mail.gmail.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-16-git-send-email-xieyisheng1@huawei.com> <s5hsh67655m.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hsh67655m.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Yisheng Xie <xieyisheng1@huawei.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

On Thu, May 31, 2018 at 9:39 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 31 May 2018 13:11:20 +0200,
> Yisheng Xie wrote:
>>
>> match_string() returns the index of an array for a matching string,
>> which can be used instead of open coded variant.
>>
>> Cc: Clemens Ladisch <clemens@ladisch.de>
>> Cc: Jaroslav Kysela <perex@perex.cz>
>> Cc: Takashi Iwai <tiwai@suse.com>
>> Cc: alsa-devel@alsa-project.org
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>
> Applied, thanks.

Is it too late for nitpick?

-- 
With Best Regards,
Andy Shevchenko
