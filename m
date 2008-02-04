From: CAG <cag@fsk-hh.org>
Subject: Re: M-Delta Audiophile 192 (ice1724) Recording
Date: Mon, 04 Feb 2008 15:31:10 +0100
Message-ID: <47A721AE.6090205@fsk-hh.org>
References: <47A24665.80402@fsk-hh.org>	<47A250E7.8040005@fsk-hh.org>
	<s5hd4rg3m7x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.nadir.org (mail.nadir.org [217.114.68.227])
	by alsa0.perex.cz (Postfix) with ESMTP id AAAF224406
	for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2008 15:33:38 +0100 (CET)
In-Reply-To: <s5hd4rg3m7x.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

hi,

Takashi Iwai schrieb:
> At Thu, 31 Jan 2008 23:51:19 +0100,
> Computer AG im FSK wrote:
>> Hi,
>>
>> I  forget to mention that we patched
>> /usr/local/src/alsa-driver-1.0.16rc2/alsa-kernel/pci/ice1712/revo.c
>> instead of
>> /usr/local/src/alsa-driver-1.0.16rc2/pci/ice1712/revo.c
>>
>> because /usr/local/src/alsa-driver-1.0.16rc2/pci/ice1712/revo.c is just
>> 3 lines long or so and looks like including
>> /usr/local/src/alsa-driver-1.0.16rc2/alsa-kernel/pci/ice1712/revo.c.
>>
>> Does this matter ?
> 
> No, it's the right place to apply.
> 
> So far, I have no further idea what could be wrong.  It's really hard
> to debug remotely without hardware and without any datasheet... >
> 
> Takashi

We get this card working with O.S.S., recording works now. Anyway, OSS 
is not our preferred sound system...

We would like to know if there will be future development for this card. 
We bought 4 cards for our studio, it really would help us out.

Is there any way to support the alsa project to fix this issue ? What 
about our offer to lend a card for development ? Our finances aren't 
very well but  we could also think about a small donation for hardware 
i.e.

Our alternative is to sell our 4 cards on Ebay buy 4 other ones...

Thanks anyway for your effort,

Toast
