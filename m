From: =?UTF-8?B?SWx5YSBEaWthcmlldg==?= <dik_again@mail.ru>
Subject: =?utf-8?q?M-Audio_Midisport_2x2_Anniversary_edition?=
 =?utf-8?q?=2C_latency_problem?=
Date: Tue, 28 Apr 2015 11:18:37 +0300
Message-ID: <1430209117.53049092@f91.i.mail.ru>
Reply-To: =?UTF-8?B?SWx5YSBEaWthcmlldg==?= <dik_again@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f91.i.mail.ru (f91.i.mail.ru [94.100.185.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 93A5926041D
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 10:18:38 +0200 (CEST)
Received: from [188.102.102.195] (ident=mail)
 by f91.i.mail.ru with local (envelope-from <dik_again@mail.ru>)
 id 1Yn0iz-0007br-Nt
 for alsa-devel@alsa-project.org; Tue, 28 Apr 2015 11:18:38 +0300
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

Hi all,

I bought a MIDI-interface von M-Audio (see subject), but there are strange things with it on my desktop (Arch, latest kernel). The latency is about 5 seconds. If I reconnect cabels, the latency can change from 5 sec to 0.5 sec, or to ~0sec, but in 90% of all the tries, the latency stay at 3-5 sec.

I tried it on my older laptop (kernel 2.6.32 from Ubuntu 10.04) and it works! I think it's a regression. How can I help to fix this bug?

best regards,
Ilya.
