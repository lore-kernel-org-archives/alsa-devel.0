From: Gernot Kohlhaas <gernot.kohlhaas@googlemail.com>
Subject: Testers wanted: New SB X-Fi driver
Date: Sun, 07 Jun 2009 15:08:29 +0200
Message-ID: <4A2BBBCD.3070401@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id D300D24500
	for <alsa-devel@alsa-project.org>;
	Sun,  7 Jun 2009 15:08:30 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 22so506113fge.21
	for <alsa-devel@alsa-project.org>; Sun, 07 Jun 2009 06:08:30 -0700 (PDT)
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

Hi!

I found a little strange thing:
Recording from microphone is only possible, when you unmute the
"Line-In" playback-device (and set microphone as capture device, of course).

Oh, and by the way: Is there any possibility to apply a low pass filter
to the subwoofer-channel without using ladspa (xmms and audacious won't
play songs with my low pass filter. Mplayer, xine and aplay are working
fine).

Thanks again for this driver :)
-- 
http://www.gnupp.de/verschluesselung/warum.html
Key ID: 0x4C0B2250
Key: http://home.arcor.de/mr_maniac/ANDERES/public.gpg
