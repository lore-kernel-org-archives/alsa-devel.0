From: erumusele Odigie <erumusele@gmail.com>
Subject: Setting gain/volume of PCM capture or playback
Date: Fri, 5 Jun 2009 19:22:55 -0700
Message-ID: <edeadc8c0906051922m2b0d7e97we01bff33157d5197@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by alsa0.perex.cz (Postfix) with ESMTP id EAFBA243F4
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Jun 2009 04:22:56 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c3so1044101ana.2
	for <alsa-devel@alsa-project.org>; Fri, 05 Jun 2009 19:22:55 -0700 (PDT)
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

Hi,

I am new to programming with ALSA, and I would like to find out how to
change the gain (capture or playback) for my PCM device in my C code.

I am aware I am supposed to use the mixer API, possibly functions like:
snd_mixer_selem_set_playback_volume()

but I don't know how this function can be connected to my PCM
structure/device.

Please whoever answers this should kindly attach some sample code, or a link
to sample code because I can't find any on line.

Thanks a lot.

Erumusele
