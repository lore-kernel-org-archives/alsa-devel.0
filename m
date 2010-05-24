From: Pedro Ferreira <ilzogoiby@gmail.com>
Subject: Re: USB midi support for KAOSS pad
Date: Tue, 25 May 2010 00:34:03 +0200
Message-ID: <AANLkTik4fUbdlrhDZWEVxckWgpiSDPvo2snpU-5cHWBd@mail.gmail.com>
References: <AANLkTimUYbWSqsahW9m8AbIjZuT-yVvnkGpnfCrLyi8u@mail.gmail.com>
	<20100524153324.GL30801@buzzloop.caiaq.de>
	<AANLkTil4vczJ2ymOEAUCRQBfZroxxtRpWpC6Wl3TgcUq@mail.gmail.com>
	<20100524205319.GP30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B1EE103830
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 00:34:06 +0200 (CEST)
Received: by vws6 with SMTP id 6so1482736vws.38
	for <alsa-devel@alsa-project.org>; Mon, 24 May 2010 15:34:04 -0700 (PDT)
In-Reply-To: <20100524205319.GP30801@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

> And here, the device is disconnected from USB, but I doubt that is
> related to the driver stack. The only thing I can currently think of is
> that the device draws too much power at this point, and a voltage
> brown-out causes the device to reset. Can you try a powered hub, or is
> this device powered by an external supply anyway?

It's got its own power supply :)

> Did you successfully
> use it on the _same_ hardware under Windows?

Haven't tried... I don't have windows on this machine :/

Thanks,

Pedro
