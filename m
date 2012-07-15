From: Anand Joseph <joseph.anand@gmail.com>
Subject: Status of USB audio class 2 drivers in ALSA
Date: Mon, 16 Jul 2012 02:33:34 +0530
Message-ID: <CAFi4vu-LeUyVg_wz_OkMVTrGbc-n1e6MKoJwo+iTHgbwD5s0zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 03A7424986
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Jul 2012 23:03:35 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so7663671obb.38
	for <alsa-devel@alsa-project.org>; Sun, 15 Jul 2012 14:03:34 -0700 (PDT)
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

I am working on building a multi-channel USB audio device using the
PIC32MX2 series with dual WM8731 audio codecs. The goal is a low cost
4 channel USB audio device. While this might not be the best
combination for
multi-channel audio, I do not have a better solution as the XMOS
series is not easily available in India. I would like to know the
status of USB audio class 2 support in ALSA and is there anyway I can
contribute. I did go through the USB specifications for audio class 2
devices, but an idea of the implementation in ALSA would help in
writing the firmware.

Regards,

Anand
