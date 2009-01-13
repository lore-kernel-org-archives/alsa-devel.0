From: Adrian McMenamin <lkmladrian@gmail.com>
Subject: Re: Fixing the AICA driver
Date: Tue, 13 Jan 2009 09:57:25 +0000
Message-ID: <8b67d60901130157o5afb1920n3ef1d9bef746550e@mail.gmail.com>
References: <8b67d60812291120i58473762i679f5783b651f803@mail.gmail.com>
	<s5hocyjv0ou.wl%tiwai@suse.de>
	<1231440646.6620.1.camel@localhost.localdomain>
	<s5h63kp3q12.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f20.google.com (mail-bw0-f20.google.com
	[209.85.218.20])
	by alsa0.perex.cz (Postfix) with ESMTP id A686D1037EF
	for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2009 10:57:26 +0100 (CET)
Received: by bwz13 with SMTP id 13so29861453bwz.8
	for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2009 01:57:25 -0800 (PST)
In-Reply-To: <s5h63kp3q12.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Adrian McMenamin <adrian@newgolddream.dyndns.info>
List-Id: alsa-devel@alsa-project.org

2009/1/9 Takashi Iwai <tiwai@suse.de>:
> At Thu, 08 Jan 2009 18:50:46 +0000,
> Adrian McMenamin wrote:
>>
>> On Wed, 2009-01-07 at 12:02 +0100, Takashi Iwai wrote:
>>
>> >
>> > Could you try the git version?  I thought I fixed the relevant bug recently.
>> >
>> >
>> > Takashi
>>
>> Hi Takashi - I assume you mean in the alssa-driver git, as I am using
>> the bleeding edge kernel stuff already?
>
> No, I mean alsa-lib.  There is mmap_emul plugin in alsa-lib but it
> didn't work well.
>

There is a special part of hell where the damned spend eternity cross
compiling alsa-lib.

But I'll have a go when I get the time in the enxt week or so.
