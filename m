From: =?ISO-8859-1?Q?Fl=E1vio_Martins?= <xhaker@gmail.com>
Subject: Laggy mixer with Xonar DX snd_virtuoso
Date: Sun, 11 Apr 2010 01:49:20 +0100
Message-ID: <x2t9374ce781004101749lede8799foaa7b92ae40034c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 6233210380D
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Apr 2010 02:49:21 +0200 (CEST)
Received: by bwz20 with SMTP id 20so4749368bwz.32
	for <alsa-devel@alsa-project.org>; Sat, 10 Apr 2010 17:49:21 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Alsa team,

I have a Xonar DX with a laggy volume control, you might have guessed alrea=
dy.
Sound will interrupt if the volume change is big like from 100% to
50%, it will only
skip a bit if the volume change is smaller. The interruptions/silence
last more than
5 seconds easily. I can actually see the mixer slider going up and
down on its own.

I am seeking for your help and i'm using 1.0.22.1.

Here goes the alsa-info.sh output, some weird things going on in dmesg
http://www.alsa-project.org/db/?f=3Dee911fe73baa60aac51c62ff787ab8b8bd8565e8

Fl=E1vio Martins
