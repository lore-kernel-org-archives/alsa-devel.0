From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC 0/2] conf/ucm: bytcht-es8316 support
Date: Mon, 7 Jan 2019 12:44:27 +0100
Message-ID: <d822c3f8-0c52-4d48-5e3c-563216a18ec1@perex.cz>
References: <20190103135015.14669-1-hdegoede@redhat.com>
 <7a570574-9ce3-441d-f82a-81d2705340fc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 174C0267B50
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 12:44:34 +0100 (CET)
In-Reply-To: <7a570574-9ce3-441d-f82a-81d2705340fc@redhat.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, linux@endlessm.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Dne 7.1.2019 v 12:08 Hans de Goede napsal(a):
> Hi,
> 
> On 03-01-19 14:50, Hans de Goede wrote:
>> Hi All,
>>
>> Here is the UCM profile to match the kernel patches which I just submitted
>> upstream. Note this series is RFC for now, since it depends on the name
>> of a few controls added by the kernel series, as well as on the long_name
>> set by the kernel series.
>>
>> Once the kernel series has been merged into -next, this UCM profile series
>> can be merged as well. I will send another mail when the kernel series has
>> been accepted.
> 
> The kernel patches for this are in -next now, so the alsa-lib patches from
> this series are now no longer RFC and can be merged now.

I applied both patches. Thanks.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
