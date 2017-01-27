From: =?UTF-8?B?SsO2cmcgTcO8bGxlcg==?= <joerg.mueller7744@gmail.com>
Subject: Re: Cannot combine audio devices with more than 64
	channels
Date: Fri, 27 Jan 2017 14:03:16 +0100
Message-ID: <CAKw=HF1H6BCrvgm_8eL3f-L0yoKrqTqBib0kE4z0o73yzGqPKg@mail.gmail.com>
References: <CAKw=HF0hbhxJ1YGjukjFr72xtEh2FjtH6k0Bh+rFcMwejgwcUg@mail.gmail.com>
 <1cdef19b-a458-7441-2ede-2ba8984ec7cd@ladisch.de>
 <s5hh94khiao.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 1820726764E
 for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2017 14:03:17 +0100 (CET)
Received: by mail-oi0-f66.google.com with SMTP id w144so20580432oiw.1
 for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2017 05:03:17 -0800 (PST)
In-Reply-To: <s5hh94khiao.wl-tiwai@suse.de>
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

Thanks for the patch, that was fast!

So I want to apply that patch to my system (Ubuntu Studio 14.04). How
do I proceed? I guess, the patch wont be available via apt-get soon,
right?
So I'd have to compile from source.
1. What source code packages do I need to download?
2. I'm familiar with the usual "/.configure", "make" and "sudo make
install" but in the case of this specific alsa-module, is there
anything more I'd need to do?
