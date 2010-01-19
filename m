From: Michael Qiu <fallwind@gmail.com>
Subject: Re: About audio driver architecture
Date: Tue, 19 Jan 2010 16:46:54 +0800
Message-ID: <f74f98341001190046t2a2629a3v5e77e48f85260e07@mail.gmail.com>
References: <f74f98341001182326s1c03d5e2va470207ff194c2ad@mail.gmail.com>
	<53baa24a1001190004l74390c34y95608343937634a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f210.google.com (mail-gx0-f210.google.com
	[209.85.217.210])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A7DE2450E
	for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2010 09:46:55 +0100 (CET)
Received: by gxk2 with SMTP id 2so3891301gxk.4
	for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2010 00:46:54 -0800 (PST)
In-Reply-To: <53baa24a1001190004l74390c34y95608343937634a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

That's what I want, thanks a lot . And It's a soc still under developping.

2010/1/19 Alex Austin <circuitsoft.alex@gmail.com>:
> http://www.alsa-project.org/main/index.php/ASoC
>
> Perhaps that's what you're looking for? What processor are you using? The=
re
> may already be implementations for it.
>
> On Tue, Jan 19, 2010 at 1:26 AM, Michael Qiu <fallwind@gmail.com> wrote:
>>
>> Hi,
>> =A0I'm going to write an audio driver for a developping soc used for
>> dvb set top box.
>> As I've never done such things before, so I've some questions.
>> 1. Seems the "ALSA Driver Documentation" is mainly for PCI(and for PC)
>> based audio card. Where can I got a document for SOC which has no PCI
>> bus. If there are some existing drivers it will be even better.
>> 2. Is there any standard for such a audio driver which upper
>> applications will depend on it? Or I can just follow ALSA?
>>
>> Best regards
>> Michael Qiu
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
