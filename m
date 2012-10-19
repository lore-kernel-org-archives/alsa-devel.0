From: Prasant J <pj0585@gmail.com>
Subject: Re: Non-interleaved with plughw
Date: Fri, 19 Oct 2012 15:59:29 +0530
Message-ID: <CAA2DH4ve3Cs5orw20pZhhwYQuc6A7w2Xi7gvEWWHLV6B5Zvx1Q@mail.gmail.com>
References: <CAA2DH4uZAFL32NKzirGoVXATTxBuT4xM-wVA3pw_v6HV8X=oHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id F10C12625E9
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 12:29:29 +0200 (CEST)
Received: by mail-qa0-f44.google.com with SMTP id 25so31293qao.17
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 03:29:29 -0700 (PDT)
In-Reply-To: <CAA2DH4uZAFL32NKzirGoVXATTxBuT4xM-wVA3pw_v6HV8X=oHQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 19, 2012 at 3:52 PM, Prasant J <pj0585@gmail.com> wrote:
> Hi,
>
>
> My hardware supports only interleaved access and I'm recording and
> playing using hw:0,0. Currently I provide interleaved buffers to the
> device.
>
> What I read is that plughw device can convert non-interleaved buffers
> to interleave buffers before sending to hardware. I want to reduce
> complexity of my application and want to use plughw.
>
> But I'm not able to get good documentation or examples of the same.
> Can anyone point out to me?
>
>
> Regards,
> -Prasant

or is it the PCM plugin: Copy ??
Any examples?

-Prasant
