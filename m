From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: How to use implicit feedback with full duplex?
Date: Thu, 7 Feb 2013 10:03:20 +0100
Message-ID: <CAFz=ag4aVMoEcYiZ4BKbqAoN7PuwvrhDa-162183JdsdYhDK_w@mail.gmail.com>
References: <51116F36.9040106@ladisch.de>
 <alpine.LNX.2.00.1302052326150.1207@xoschi>
 <5112B969.50905@ladisch.de> <5112BB1C.8090105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 12E75265260
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2013 10:03:21 +0100 (CET)
Received: by mail-lb0-f173.google.com with SMTP id gf7so1952730lbb.18
 for <alsa-devel@alsa-project.org>; Thu, 07 Feb 2013 01:03:20 -0800 (PST)
In-Reply-To: <5112BB1C.8090105@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Eldad Zack <eldad@fogrefinery.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Daniel, Hi Eldad.

2013/2/6 Daniel Mack <zonque@gmail.com>
>
> I'll look for the FTU and re-try this with Eldad's latest additions once
> I find some time.
>
>
I'll probably find some time later next week. I haven't followed thoroughly
what Eldad did for the C400/C600 but wanted to play around with the FTU
anyway (if I remember correctly there was a patch dropping the first n
implicit feedback packets on the C400 that might possibly be of benefit for
the FTUs as well).

@Eldad Have your latest additions already made it into Takashi's tree or
where can I find them?
