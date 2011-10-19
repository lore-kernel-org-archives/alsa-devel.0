From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: ssm2602: Use snd_soc_update_bits for read-modify-write
Date: Wed, 19 Oct 2011 14:07:52 +0200
Message-ID: <4E9EBD98.9090705@metafoo.de>
References: <1319004451.16275.1.camel@phoenix> <1319012280.4133.0.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1319012280.4133.0.camel@odin>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/19/2011 10:18 AM, Liam Girdwood wrote:
> On Wed, 2011-10-19 at 14:07 +0800, Axel Lin wrote:
>> Use snd_soc_update_bits for read-modify-write register access instead of
>> open-coding it using snd_soc_read and snd_soc_write
>>
>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> 
> Acked-by: Liam Girdwood <lrg@ti.com>
> 

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
