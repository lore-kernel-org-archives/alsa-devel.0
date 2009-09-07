From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: [PATCH] AC97 atmel: add support for AT91(common
	with AVR32).
Date: Mon, 07 Sep 2009 09:32:02 +0200
Message-ID: <4AA4B6F2.7020601@atmel.com>
References: <s5h1voooj8u.wl%tiwai@suse.de>	<1247231207-22922-1-git-send-email-sedji.gaouaou@atmel.com>	<4A7ADF2B.4080807@atmel.com>	<s5hk51h11zy.wl%tiwai@suse.de>	<4A7BDA04.40300@atmel.com>
	<s5hzlabygn8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 19DA21037EA
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 09:32:50 +0200 (CEST)
In-Reply-To: <s5hzlabygn8.wl%tiwai@suse.de>
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

Hi Takashi,

Just a quick e-mail to let you know that Russel has applied the "board" =

patch regarding the AC97 on =

AT91(http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3D5640).

So you can apply to your tree the rest of the patch.

Regards,
Sedji

Takashi Iwai a =E9crit :
> At Fri, 07 Aug 2009 09:38:44 +0200,
> Sedji Gaouaou wrote:
>> Hi,
>>
>> I have submited the board part to the arm-linux patch traking system: =

>> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3D5640
>>
>> I'll keep you inform if it is applied or not, so you can add the ac97 =

>> part to your git, is that ok for you?
> =

> Fair enough.
> =

> =

> thanks,
> =

> Takashi
> =

>> Regards,
>> Sedji
>>
>> Takashi Iwai a =E9crit :
>>> At Thu, 06 Aug 2009 15:48:27 +0200,
>>> Sedji Gaouaou wrote:
>>>> Hi,
>>>>
>>>> I was wondering what is the status of this patch?
>>> Well, it's not clear who will take which patches.
>>>
>>> Are other changes like the one in at91 side already merged in
>>> linux-arm tree?  If so, I'll apply only ac97-atmel patch.
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>>>
>>
> =
