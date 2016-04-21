From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: A&H Zed R16 not completely working (DICE Jr)
Date: Thu, 21 Apr 2016 18:49:42 +0900
Message-ID: <5718A236.3070104@sakamocchi.jp>
References: <CA+aoAJc6JQvy_yk-5HJZpqv5GW6DygdmLB5=HGyW9q3yn12mKA@mail.gmail.com>
 <57179E91.1070202@sakamocchi.jp>
 <CA+aoAJcCYpaXhX4+w9ViHN9J0Uz+QgUWwCb_-U4WzkoOVZR3+g@mail.gmail.com>
 <57181862.6060501@sakamocchi.jp>
 <CA+aoAJeOKtxGQXVKPLRYLO5KHMY7fDUZ4YKYHUUVyki_Sh3PBA@mail.gmail.com>
 <571836C0.40605@sakamocchi.jp>
 <CA+aoAJeU=y=mP0=_xeQXDfcG5uWg8azpuddQG6MxJ=NEZkA31A@mail.gmail.com>
 <57185E39.5090401@sakamocchi.jp>
 <CA+aoAJdVcu0C6KiLEDTf38awUAjtk2xddumicFNRw-QXx2Ww2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FD70260711
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 11:49:45 +0200 (CEST)
In-Reply-To: <CA+aoAJdVcu0C6KiLEDTf38awUAjtk2xddumicFNRw-QXx2Ww2w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Allan Klinbail <aklinbail@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

First, I have no hostility to you.

Since I extended snd-dice in the late of 2014, I have been exposed to 
the similar insistences many times, in public or private, from users who 
own Dice-based models. Their insistences tends to include unreasonbable 
judgements about something related, ignorance of developers' intension 
and the state of development for ALSA firewire stack. So I feel to have 
a waste of time to receive such intensions, because they're not 
productive at all.


On Apr 21 2016 14:38, Allan Klinbail wrote:
> As I admitted, my understanding is basic and limited. Clearly I have got it
> wrong.
>
> However, (snip)

Well, you still repeat the same insistences again, after our discussion. 
It means that I fail to refresh your knowledge about PCM frame handling 
in this operating systems. That's a pretty sad to me.


One of my motivation to work for ALSA firewire stack is to use sound and 
music units on IEEE 1394 bus for the purpose as you described, via ALSA 
kernel/userspace interface, according to ways reasonable to many system 
requirements.

The shape of ALSA firewire stack represents the requrements from design 
of actual operating system, actual sound subsystem in Linux, actual 
audio and music units on IEEE 1394 bus, actual packet streaming protocol 
and actual quirks of the units. If you need my technical explaination 
about them, I'm willing to describe them. You won't accept it even if I 
did, because I've already introduced a part of them and you won't 
refresh your brain.

This is the end of such an unproductive discussion, sorry.


Regards

Takashi Sakamoto
