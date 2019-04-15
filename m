From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] ALSA: isa/wavefront: Fix potential Spectre v1
 vulnerabilities
Date: Mon, 15 Apr 2019 17:40:27 -0500
Message-ID: <f2a81b0f-ac5e-9161-cf48-74dbc65d8a1f@embeddedor.com>
References: <20190326183202.GA17285@embeddedor>
 <52a533e5-f106-db5f-35f7-2dd85672f541@embeddedor.com>
 <s5hef62kidq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hef62kidq.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 4/15/19 5:34 PM, Takashi Iwai wrote:
> On Mon, 15 Apr 2019 21:35:17 +0200,
>  Gustavo A. R. Silva  wrote:
>>
>> Hi all,
>>
>> Friendly ping:
>>
>> Who can take this?
> 
> All platforms that support ISA boards are so old and they don't suffer
> from Spectre at all.
> 

Oh okay.

I'll take this info into account for future changes.

Thanks
--
Gustavo
