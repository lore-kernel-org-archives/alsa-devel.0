From: oeaiyu <oeaiyu@gmail.com>
Subject: emu 1212m devel, firmware
Date: Tue, 30 Oct 2012 15:07:12 +0400
Message-ID: <508FB4E0.5090703@gmail.com>
Reply-To: oeaiyu@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id D64DF26533D
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 12:08:25 +0100 (CET)
Received: by mail-la0-f51.google.com with SMTP id m15so89051lah.38
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 04:08:24 -0700 (PDT)
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

Aloha!

the thing is about emu 1212m - yep i know it's not working, but i can help
to debug some and try to do something with it, i'm programming sometimes but
not C, but i can debug and send you bugtrack and i can log win7 x64 if you
really need it, i'm trying to not using it to spend some time to discover
linux bugs - it's funny thing =)) alotofw3rkz hea
i got 4 sound cards in comp
i'm musician - you can listen some of my music @ symbiants.com i can send
you some if you wish to.
and for writing music 7 years ago or so i've bought that
    emu card
+creative x-fi
+ ati r6xx hdmi
+ hda ati sb ad1988b

not sure about r6xx. but all others are working, but emu
it shows me e-mu 1010b PCI MAEM8960
but it is e-mu 1212m pci actually - the chip is similar but it's other it is
like 1818m, of course the chip itself is audigy2 but the connectors are
others it is very simple - i think just need to reroute some in / out
also i know exactly that in latest drivers there was a firmware update
(2.0.0.18 or something latest for win7) so the firmware is in the bundle
that can be extracted from installer.

well about in out some more - i got some front / surround /center / lfe /
side sliders and more - i can send print screen if needed, but in hardware
level i got
adat/spdif in/out
left \ right in jacks
left \ right out jacks
midi in \ out
and special for micro-dock (this is why it is ":m") input - ethernet like
that is not active
also there are special pins on the card that splits card for two pieces and
those ananlog in+out are with midi together and all spdif adat on the other
part of card that interconnected via harddrive like ide-cable.

well right now the main bug for me is that when i'm enabling this emu card, the emu-firmware is loading and it gets about 25% of CPU well this is a 1 full core, so i think that it would take the whole 100% if those cores wasn't separated or something.
well as i suppose this is the firmware problem that is not suited for this hardware.

  

-- 
RA
OEAI
