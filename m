From: =?UTF-8?Q?Gilles_Gr=C3=A9goire?= <gilles.gregoire@gmail.com>
Subject: Re: iMX233 audio capture: glitches on task switch?
Date: Mon, 14 Apr 2014 17:17:41 +0200
Message-ID: <CANpMpoT1rTiPFygzgevvzz9Vt_r9yoHpBeCqfnNv1VTLLHFXZA@mail.gmail.com>
References: <CANpMpoTQM9vpr8g+FFjkAiwh6fEKq-Qn_txD72pj2WrFQL5D_w@mail.gmail.com>
 <CAOMZO5AgghFwnZtH0AVsnxoaFAH-9KU5_CRWJ4Lvxptx7fGY2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f181.google.com (mail-ie0-f181.google.com
 [209.85.223.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 69807265489
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 17:17:45 +0200 (CEST)
Received: by mail-ie0-f181.google.com with SMTP id tp5so8208698ieb.40
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 08:17:42 -0700 (PDT)
In-Reply-To: <CAOMZO5AgghFwnZtH0AVsnxoaFAH-9KU5_CRWJ4Lvxptx7fGY2Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> I would suggest you to post the initial driver support as a formal
> patch to this list first.
>
> As you mentioned that playback works fine, you could start by adding
> the mx23 audio driver with playback support only.
>
> Once the initial submission is accepted, then we could look at the
> recording side.

The patch is a work in progress: a lot of cleanup is needed to make it
acceptable.

Also, I am not a kernel developer: not sure I can make it. But I'll try!

-- Gilles
