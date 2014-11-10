From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: [PATCH 2/2] snd-usb-audio: Add duplex mode for
 Digidesign Mbox 1 and enable mixer
Date: Mon, 10 Nov 2014 12:33:29 +1100
Message-ID: <546015E9.8060103@gmail.com>
References: <1415059597-18344-1-git-send-email-damien@zamaudio.com>
 <1415059597-18344-3-git-send-email-damien@zamaudio.com>
 <s5ha9442z6d.wl-tiwai@suse.de> <545E1C21.3090803@gmail.com>
 <s5hk3343f6y.wl-tiwai@suse.de> <545F747A.7090002@ladisch.de>
 <s5hfvds2sjo.wl-tiwai@suse.de> <545FFC8F.9040001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 86E442605AB
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 02:33:45 +0100 (CET)
Received: by mail-pa0-f41.google.com with SMTP id rd3so7159406pab.28
 for <alsa-devel@alsa-project.org>; Sun, 09 Nov 2014 17:33:44 -0800 (PST)
In-Reply-To: <545FFC8F.9040001@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 10/11/14 10:45, Damien Zammit wrote:
Or did I miss something silly?

Yes, I think I accidentally removed my USB core drivers when I ran make
modules from sound/ and installed them over the top of my dpkg'ed kernel.

Will confirm this when I complete a full module compile.

Damien
