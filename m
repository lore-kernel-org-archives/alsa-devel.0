From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Invalid PCM pointer with CMI8738 and pcm.c buffer
 underuns
Date: Tue, 01 Apr 2014 13:37:29 +0200
Message-ID: <533AA4F9.4040508@ladisch.de>
References: <CAAvHfitJ2B1sr7_6h=ww_SVGgsuy4iNLGc3CjDyiNtwdpJTSUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id CB52A2652AC
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 13:37:30 +0200 (CEST)
In-Reply-To: <CAAvHfitJ2B1sr7_6h=ww_SVGgsuy4iNLGc3CjDyiNtwdpJTSUw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andoru <andoru.blah@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Andoru wrote:
> The last time you replied you said that it's a hardware error. If it
> is that way then how come the card otherwise works flawlessly in
> Windows, and this doesn't happen on Debian when watching videos or
> with certain programs?

It's still a hardware error, but, apparently, it happens only when the
Linux driver accesses it in a certain way.

Which programs work?  Which do not?


Regards,
Clemens
