From: Peti Pap <roachkiller44@gmail.com>
Subject: Re: M-audio Audiophile Firewire
Date: Sun, 23 Oct 2016 12:48:27 +0200
Message-ID: <CAPzTivFtjdmpEOYJo=a=B12_Zf9UVV+SjRUKA9hNWLop3w5nbg@mail.gmail.com>
References: <CAPzTivG=yDAbFZo+u5qauE_LdpqhUM5fT9MT9+hrmi3gTsTGqw@mail.gmail.com>
 <1f6dd683-f550-651b-93d2-87560dd298ff@sakamocchi.jp>
 <fd56b817-96b3-1784-725c-21a5bef7497a@sakamocchi.jp>
 <CAPzTivEubUhef5LR_p3y0_4TZtbwoLimvzU-tx=xmUhBnT+T0g@mail.gmail.com>
 <CAPzTivHypNMZvBVBks=wpx1XakELyeWsBVD9mpq-risb_DtH=Q@mail.gmail.com>
 <7f5bc2fc-7e45-2577-9286-be0e2ff74228@sakamocchi.jp>
 <CAPzTivHqY1aBH2hqHetmd7-hdZsPbPsC8e1iMjgL=2myH91fbg@mail.gmail.com>
 <a2d308f4-1982-8418-40ec-e783065f7a96@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f47.google.com (mail-it0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F0592666BB
 for <alsa-devel@alsa-project.org>; Sun, 23 Oct 2016 12:48:29 +0200 (CEST)
Received: by mail-it0-f47.google.com with SMTP id e187so93082904itc.1
 for <alsa-devel@alsa-project.org>; Sun, 23 Oct 2016 03:48:29 -0700 (PDT)
In-Reply-To: <a2d308f4-1982-8418-40ec-e783065f7a96@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Now I restart the system, and the FFADO-Mixer working, there have a lot of
settings, I tried some, but I noticed when I try to play a youtube video or
mp3 the sound is "creak". And when I try to set 48khz, after an m3 playing
always 'recoil' to 44.1
I want use this unit as a simple stereo 48khz sound device, to playing mp3
wav and videos, and recording/make music in Tracktion.


2016-10-23 11:23 GMT+02:00 Takashi Sakamoto <o-takashi@sakamocchi.jp>:

> On Oct 23 2016 18:03, Peti Pap wrote:
> > Excuse me;
> >
> > "When the power LED turns at green color instead blinking, ALSA bebob
> > driver successfully makes the unit to load firmware"
> >
> > The unit already stopped blinking after a basic linux installation (from
> > the first boot). But no any "green" LED, only(!) the power LED lighting,
> > but the power LED color is blue.
> > So, I reinstalled - again - my system, and now I dont know what can I do
> > :|
>
> Ah, sorry. It shoud be turns at blue color... When you can see any ALSA
> PCM nodes for your unit, the unit loads firmware correctly.
>
>
> Regards
>
> Takashi Sakamoto
>
