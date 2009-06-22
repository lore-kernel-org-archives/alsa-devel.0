From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Subject: Re: Regarding Sound on Acer Aspire 6935G
Date: Mon, 22 Jun 2009 20:19:21 -0300
Message-ID: <d54969c50906221619w5e32e9d8y1fb9e0131b935dcf@mail.gmail.com>
References: <4b8c423b0905152051w7443e1b4u4080514a560fbb6c@mail.gmail.com>
	<1245628845.13319.10.camel@localhost>
	<d54969c50906221044x1f8070b0s1fe802f08c63e7@mail.gmail.com>
	<s5h3a9sm8oa.wl%tiwai@suse.de>
	<d54969c50906221451o6e92044cj3da24df67e55268b@mail.gmail.com>
	<1245707939.441.5.camel@localhost> <s5hfxdrex0w.wl%tiwai@suse.de>
	<1245709097.441.7.camel@localhost> <1245710676.441.9.camel@localhost>
	<d54969c50906221614k5e12f5edt8973f7bb8e69592c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E3782414A
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 01:19:22 +0200 (CEST)
Received: by qyk1 with SMTP id 1so4205551qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2009 16:19:21 -0700 (PDT)
In-Reply-To: <d54969c50906221614k5e12f5edt8973f7bb8e69592c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Vroon <tony@vroon.org>
Cc: Takashi Iwai <tiwai@suse.de>, Karthik Ramgopal <applefreakpeeps@gmail.com>, ALSA development ML <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Just noticed another new issue. Jack sensing half-works, LFE isn't 'muted'
when you plug headphones, but Front is.

2009/6/22 Emilio L=F3pez <buhitoescolar@gmail.com>

> The mic worked with model=3Dacer-aspire-4930g, maybe you can "copy" the
> information from that model or something? I don't really know how alsa
> works, it's just an idea.
>
> 2009/6/22 Tony Vroon <tony@vroon.org>
>
> On Mon, 2009-06-22 at 23:18 +0100, Tony Vroon wrote:
>> > It quite likely is, I got tired of 4930g not working right and cleared
>> > it all out. I've been granted remote access to the 6530g in question,
>> > and hope to submit a patch to you in the next 20 minutes.
>>
>> I'm getting overruns and corrupt data galore.
>> arecord outputs miles and miles of:
>> overrun!!! (at least -1245709895929.816 ms long)
>>
>> Please advise.
>>
>> Regards,
>> Tony V.
>>
>
>
