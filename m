From: Luca Novarini <luca.novarini@gmail.com>
Subject: Re: US-1641 drivers involvment
Date: Thu, 29 Aug 2013 15:57:20 +0200
Message-ID: <CA+5WxHLQ-Ao80aUVg6nt2shYJ=7GFWvVuQqyMVC92Lm1obWgEA@mail.gmail.com>
References: <CA+5WxH+L75iiV4OkXoHAZk38AG9984VLctGNKm+61nTh4P2XTA@mail.gmail.com>
 <521F4639.2060600@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 856B626172B
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 15:57:21 +0200 (CEST)
Received: by mail-la0-f53.google.com with SMTP id el20so394434lab.12
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 06:57:21 -0700 (PDT)
In-Reply-To: <521F4639.2060600@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Clemens for your fast answer!
The vendor (Tascam) said that US-1641 driver are based on an identical
concept as US-144 drivers, so far we should proceed in the same fashion I
think....
Have you idea where I can find further infos on how US144 drivers works?

Thank again! Regards,
LL


2013/8/29 Clemens Ladisch <clemens@ladisch.de>

> Luca Novarini wrote:
> > I'm writing you to know how can I participate in the growth of ALSA
> > supported card list to include also my current USB audio card, the
> > Tascam US-1641.
>
> >       bInterfaceClass       255 Vendor Specific Class
>
> A driver for a device with a vendor-specific protocol would require
> information from the vendor (Karsten?) or reverse engineering.
>
>
> Regards,
> Clemens
>
