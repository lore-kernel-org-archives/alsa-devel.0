From: Chemsi Mehdi <chmsmehdi@gmail.com>
Subject: How does ALSALIB commuciates with low level kernel API
Date: Wed, 15 Jun 2016 00:12:24 +0100
Message-ID: <CAHkWnPYuUgrARoMDHjg-0vSKVfz7x6tfh9cpzoEHzvEs+cvUKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f66.google.com (mail-qg0-f66.google.com
 [209.85.192.66])
 by alsa0.perex.cz (Postfix) with ESMTP id DED65265232
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 01:12:25 +0200 (CEST)
Received: by mail-qg0-f66.google.com with SMTP id t106so414063qgt.2
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2016 16:12:25 -0700 (PDT)
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

Dear experts,

I am too new in ALSA, trying to read a little bit and understand.
I want to underatnd how ALSA userspace API calls kernel space code ?
for example when I call  snd_pcm_open() which code is called in kernel
sound code ?
and how the link is made ? via IOCTL/write ?

Please clarify

Thanks a lot in advance.

Mehdi
