From: Nicolae Rosia <nicolae.rosia@gmail.com>
Subject: Re: Intel HDA & Realtek issues on ASUS G751JM
Date: Sat, 13 Jun 2015 15:48:05 +0300
Message-ID: <CAH=tA9H78dWaRk92Aojh2Z4Gw9MZyhQSb3BAqsJ6EhFB7cDVWw@mail.gmail.com>
References: <CAH=tA9HdRbRrLrKW+OeYUibjs3StwmKOUD_6p=WMu5LDK4VYzg@mail.gmail.com>
 <s5hzj47n9d1.wl-tiwai@suse.de>
 <CAH=tA9FR7vb+dFS2Mzpd7RJGrbGNRAjj9pM3BCsdVxzG_i0YAA@mail.gmail.com>
 <s5h616ul6o5.wl-tiwai@suse.de>
 <CAH=tA9E_D7Nt0iS8j9GXp3duDYN=xDn5aDt2O_cZuf1gFRArJQ@mail.gmail.com>
 <CAN8ccib4f0O5TW6Z=QzrSoRkp=EA-Km6z15TTh+HXb5me-=+NQ@mail.gmail.com>
 <CAH=tA9FE_fNf9GtmxHTwA8+4EjMS31iYRoTZcroCLAbEZpn38w@mail.gmail.com>
 <CAN8cciY8A-ecJVYyPKoRqZad+HhpOCvFtxdrrA=yTrk_q7QitQ@mail.gmail.com>
 <CAH=tA9G45ci85VvD1ZceiEcM3sp+3FKtA1B8LimENEVcC-dtFw@mail.gmail.com>
 <CAN8cciaQhhP3P-LU2KFJ8mCSTk5tcroEKpDMh4g_dtMkxV_q0A@mail.gmail.com>
 <CAN8ccib13ygePJWmQiQvmt-4wt49GnJ2BYVLAUKFckNNk0mf5A@mail.gmail.com>
 <CAH=tA9ECWF9WaeJvJcT3D-uXqr-r4Zp+TmBD88GJ6YhxQztJxA@mail.gmail.com>
 <CAN8ccibLHuYuqgypm8O7gZMwZoGUNs8-cg-1rHcPaErNGVs2Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f177.google.com (mail-lb0-f177.google.com
 [209.85.217.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 03FFF260415
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 14:48:06 +0200 (CEST)
Received: by lbbtu8 with SMTP id tu8so31598732lbb.2
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 05:48:05 -0700 (PDT)
In-Reply-To: <CAN8ccibLHuYuqgypm8O7gZMwZoGUNs8-cg-1rHcPaErNGVs2Fw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
>> Neither specification nor user manual mention the support of surround 5.1
>> It is curious because I have selected Analog Surround 5.1 Output in Sound
>> Settings (GNOME), and I can test each individual speaker (5.1). It also
>> works in Windows 8.1
>
> do windows 8.1 use mic jack as clfe or surround ?
Windows 8.1 uses mic jack for Mic In or Center/Subwoofer Speaker out
and Front Speakers are swapped with Rear Speakers.

>
> Since the user manual did not provide the mapping,
>
> http://www.intel.com/support/motherboards/desktop/sb/CS-034198.htm
>
> How do the other user know the mapping even if you implemented 5.1 ?
I don't know (?)

>
> You have to follow up the above thread about the name of volume control if
> you think your case are
>
> D: 3DACs 2 HP 1Mic 2 Speaker
