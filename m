From: Sergio Atzori <sergioatzori@gmail.com>
Subject: Some questions about devices supported by alsa
Date: Sat, 09 Feb 2008 20:33:06 +0100
Message-ID: <47ADFFF2.4050803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.187])
	by alsa0.perex.cz (Postfix) with ESMTP id D57361037EF
	for <alsa-devel@alsa-project.org>; Sat,  9 Feb 2008 20:32:58 +0100 (CET)
Received: by fk-out-0910.google.com with SMTP id f40so4060634fka.0
	for <alsa-devel@alsa-project.org>; Sat, 09 Feb 2008 11:32:57 -0800 (PST)
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

Hello, my name is Sergio Atzori. I'm a musician and I love very much
linux and open source. I have a lot of hardware for music, something
well supported by linux, something else not supported...I have some
questions:
1) Esi Juli@: reported as supported by alsa, but it isn't. Looking at
http://www.linuxdriverproject.org/twiki/bin/view/Main/DriversNeeded and
http://alsa.opensrc.org/index.php/Ice1724, this really beautiful card is
unusable in linux. I have one and I tried to get it working with some
distros, but nothing..I experience a computer freeze (kernel panic
perhaps?) in every attempt to configure it with alsa-conf, or just
opening an application that uses midi system (like Rosegarden). So I
would know, there is someone working on a better driver? Can I hope to
get it working in the near future? According to me there is a lot of
people waiting for a driver for this card, I'm waiting since 2005..
2) Miditech I2 control-37 (http://www.miditech.de/produktee_i2.htm):
beatiful usb-keyboard, not mentioned in Linux-USB device site, it does
not work in linux...I think the kernel configure it well (as
snd-usb-audio device) but I can't see it in Jack midi connections..
3) RME AES32 (and AES32express) & Lynx AES16: this driver could be
important for professional studios..if we want to put linux distros on
the professional side. I've none of them, but some people ask me to
build a professional multichannel live machine, I'd like to build a
linux based machine...there are not alternatives to these cards, because
I can build a system with more than one of them (really powerful
multichannel environment).

Thanks so much for attention.
Ciao
