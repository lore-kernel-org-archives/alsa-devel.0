From: Denis Kup <dener.kup@gmail.com>
Subject: Re: [PATCH] Acer 7730G support update.
Date: Mon, 22 Nov 2010 13:51:45 +0300
Message-ID: <AANLkTinXrkHOfmsuCmv3xTx8nG5sogY75=w399F=tZmP@mail.gmail.com>
References: <AANLkTimmcm6OcsPrB59ovYFonv5g=yrOu3_aW31UHHrO@mail.gmail.com>
	<s5hr5edrgim.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2AC0E24498
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 11:51:46 +0100 (CET)
Received: by fxm14 with SMTP id 14so4473568fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 02:51:46 -0800 (PST)
In-Reply-To: <s5hr5edrgim.wl%tiwai@suse.de>
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
Cc: Alsa Developers Maillist <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/11/22 Takashi Iwai <tiwai@suse.de>:
> At Mon, 8 Nov 2010 00:01:45 +0300,
> Denis Kup wrote:
>>
>> [1 =A0<multipart/alternative (7bit)>]
>> [1.1 =A0<text/plain; ISO-8859-1 (7bit)>]
>> Hello!
>>
>> I want to commit patch that fix no-sound on acer 7730G laptop. All work
>> history you can see here
>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D5123 .
>> This patch for the latest snapshot, where this changes have been made:
>> http://www.kerneltrap.com/mailarchive/git-commits-head/2010/5/20/35023 .
>>
>> Acer 7730G support patch.
>>
>> Changes:
>> 1) Fixes automatic EAPD configuration on Acer 7730G laptop.
>>
>> Denis Kuplyakov <dener.kup@gmail.com>
>> 8.11.10 00:00:50
>
> [Sorry for the late reply - the mail was stuck in my output queue
> =A0without triggering for weeks!]
>
> Thanks for the patch.
> Unfortunately, your patch isn't applicable as is to the latest code.
> The patch gives fuzz and errors.
>
> Could you rebase your patch to the latest 2.6.37-rc kernel code?
>
> Also, don't forget to give your sign-off. =A0It's simply a line like
> Signed-off-by: Foo Bar <foo@bar.com>
>
>
> thanks,
>
> Takashi
>

Can you send me a link to the latest version, that should I patch.
