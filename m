From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [alsa-devel] [Xen-devel][PATCH v2 3/3] ALSA: xen-front: Use Xen
 common shared buffer implementation
Date: Mon, 3 Dec 2018 11:38:49 +0200
Message-ID: <ab0405f7-6f77-14d6-7b18-8378488a3211@gmail.com>
References: <20181130074205.20496-1-andr2000@gmail.com>
 <20181130074205.20496-3-andr2000@gmail.com> <s5htvjvvtng.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5htvjvvtng.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org, jgross@suse.com, boris.ostrovsky@oracle.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

On 12/3/18 11:36 AM, Takashi Iwai wrote:
> On Fri, 30 Nov 2018 08:42:05 +0100,
> Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Use page directory based shared buffer implementation
>> now available as common code for Xen frontend drivers.
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> For the sound bits,
>    Reviewed-by: Takashi Iwai <tiwai@suse.de>
Thank you
>
> I suppose the whole patchset will be taken through xen or other tree?
Xen tree
>
> thanks,
>
> Takashi

Thank you,

Oleksandr
