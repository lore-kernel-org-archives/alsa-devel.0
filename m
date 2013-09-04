From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Documentation Request
Date: Wed, 4 Sep 2013 16:04:21 +0200
Message-ID: <CAFz=ag4f8ACnXCO9kk8vqUBvgyFTmOTT4F_N4ZFEwtGPff6jJA@mail.gmail.com>
References: <CAPOzVs4y7qc6PGps+rPzAKUUXJPuJSBowaqc2jnb=vRe9QchNg@mail.gmail.com>
 <522685BA.2030904@blennerhassett.gen.nz>
 <CAPOzVs5XUZ8RvcC4wTRp1sYZz7PP4UjnKu=qUzUcwdHkB-ta6Q@mail.gmail.com>
 <5226ECD9.7060202@faberman.de>
 <CAPOzVs45RCTiY4ykUmugVMViu6wj1KT_W8vcrpFHSVeQLAfy4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com
 [209.85.217.171])
 by alsa0.perex.cz (Postfix) with ESMTP id E44482654D8
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2013 16:04:21 +0200 (CEST)
Received: by mail-lb0-f171.google.com with SMTP id u14so435624lbd.30
 for <alsa-devel@alsa-project.org>; Wed, 04 Sep 2013 07:04:21 -0700 (PDT)
In-Reply-To: <CAPOzVs45RCTiY4ykUmugVMViu6wj1KT_W8vcrpFHSVeQLAfy4A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carl Canuck <carl.canuck.official@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2013/9/4 Carl Canuck <carl.canuck.official@gmail.com>

>
> Ignorant?  You do realize that Jack has captured the hearts and minds of
> exactly zero world renowned audio professionals, despite being
> "professional grade" according to it's developers?  Do you think that could
> possibly be a problem with Jack, or did everybody just not give it enough
> of a chance?
>


If you insist on using pure ALSA: Read the docs that Grant pointed you to.
Everything you need is there, IMO. Otherwise, using portaudio/portmidi can
help you in porting your Windows application to Linux. The tool of choice
though is: Err, you just don't want to hear that again...



> Why the hell should somebody with no experience programming with ALSA
> attempt to reverse-engineer, document and create example code when the only
> references available are some horribly inadequate API docs and a few
> kernels of wisdom scattered over years of mailing lists?


Ever so often, once you figured something out you can't see your initial
problems in understanding anymore. That's why it is a good idea to write
about such things as long as you still see your problems.

BTW, I can't see anything missing in the example code that would be
relevant to you. So what's wrong with it? What's wrong with the API docs?
It's a bit rough, sure. But it's your decision to go the hard way and not
use the adequate tool for your problem.



> I think instead
> I'll just abandon my attempts to port anything to Linux if the attitude of
> the ALSA community is that the combined use of ALSA audio and MIDI with
> proper device configuration options is supposed to be a big secret that you
> all are too busy to share.


You asked for advice. You got advice. You don't like the advice. You
complain. Hmmm. Doesn't sound right to me.
