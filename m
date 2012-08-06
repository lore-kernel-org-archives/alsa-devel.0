From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH v7] media: Add stk1160 new driver
Date: Mon, 6 Aug 2012 09:46:12 -0300
Message-ID: <CALF0-+Woc9s7_TFKyw74SAusg+YCmnFOeViP6kT0QthP4LN9zw@mail.gmail.com>
References: <1343485133-11090-1-git-send-email-elezegarcia@gmail.com>
	<CALF0-+XEStNrfdqYecKQHr=qkcFPtC5CyDC4DWWy_7+_oA0h=g@mail.gmail.com>
	<501FBBB1.1030802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <501FBBB1.1030802@redhat.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: alsa-devel@alsa-project.org, linux-media@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Hans Verkuil <hverkuil@xs4all.nl>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 6, 2012 at 9:42 AM, Mauro Carvalho Chehab
<mchehab@redhat.com> wrote:
> Em 06-08-2012 09:28, Ezequiel Garcia escreveu:
>> Hi Mauro,
>>
>> On Sat, Jul 28, 2012 at 11:18 AM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
>>> This driver adds support for stk1160 usb bridge as used in some
>>> video/audio usb capture devices.
>>> It is a complete rewrite of staging/media/easycap driver and
>>> it's expected as a future replacement.
>>>
>>> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
>>> Cc: Takashi Iwai <tiwai@suse.de>
>>> Cc: Hans Verkuil <hverkuil@xs4all.nl>
>>> Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
>>> Signed-off-by: Ezequiel Garcia <elezegarcia@gmail.com>
>>> ---
>>>
>>
>> Did you take a look at this?
>
> Patchwork didn't get it[1]. Maybe the patch got mangled?
> If so, could you please re-post?
>
> [1] http://patchwork.linuxtv.org/project/linux-media/list/?state=*&q=stk1160
>

Yes, I noticed. I sent a v5, v6 and v7; and none of them where noticed
by patchwork.
I can re-send, but I think perhaps it was due to patch size?

(alsa-devel list bounced it, for instance).

Ezequiel.
