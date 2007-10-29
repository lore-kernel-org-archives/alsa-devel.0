From: Kuten Ivan <ivan.kuten@promwad.com>
Subject: Re: PATCH: ln2440sbc ac97 support
Date: Mon, 29 Oct 2007 12:22:00 -0100
Message-ID: <4725DE78.5010700@promwad.com>
References: <20071026105408.4a4fa63b@IvanK.DOMAIN>
	<s5hr6jixh0y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from secure.poehali.org (42.242.232.72.static.reverse.ltdomains.com
	[72.232.242.42]) by alsa0.perex.cz (Postfix) with ESMTP id C88CE243C2
	for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2007 12:23:35 +0100 (CET)
In-Reply-To: <s5hr6jixh0y.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 26 Oct 2007 10:54:08 -0100,
> Ivan Kuten wrote:
>> Hello, 
>>
>> This patch adds ac97 support for ln2440sbc board from LittleChips.
>> This board is based on s3c2440 SoC + AC97 Realtek ALC650 codec. 
>> Existing s3c2443 implementation is slightly modified because s3c2440 and s3c2443
>> have different AC97 interrupts.
>>
>> Regards,
>> Ivan
>>
>> Signed-off-by: Ivan Kuten <ivan.kuten@promwad.com>
> 
> Applied to ALSA HG tree.  Thanks.
> 
> 
> Takashi

Hi Takashi,

Could you point me to correct URL for ALSA HG tree?

I checked http://hg-mirror.alsa-project.org/alsa-driver/
and http://hg-mirror.alsa-project.org/alsa-kernel/ but do not see
my patch there.

Thanks!

Regards,
Ivan
-- 
--------------------------------
Embedded Linux engineer,
Promwad Company: http://www.promwad.com/
Homepage : http://www.ivankuten.com/
--------------------------------
