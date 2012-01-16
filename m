From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 6
Date: Tue, 17 Jan 2012 07:27:53 +1100
Message-ID: <CACckToUAOk+zKwTUz2V7LxzLW3Ag2+Dk4W2DN5i_AiWwtx0NuQ@mail.gmail.com>
References: <1324656947-23169-1-git-send-email-zonque@gmail.com>
	<4EFDC32B.10808@gmail.com>
	<CAFz=ag7_qzPJq44havp=EbFVKud5VvKaOLJk0i0dM43X3urp9Q@mail.gmail.com>
	<CAFz=ag6pqhfOvxv_ScbxJFs6OEZt18GM+Dgs1KWQMG7mdZO21g@mail.gmail.com>
	<CACckToXJAJxGo-LSM3X-q=6Vo=-KzuE2Om9bgFiDnWPFNWmnSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C2E010390B
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2012 21:27:53 +0100 (CET)
Received: by lagr15 with SMTP id r15so1661724lag.38
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2012 12:27:53 -0800 (PST)
In-Reply-To: <CACckToXJAJxGo-LSM3X-q=6Vo=-KzuE2Om9bgFiDnWPFNWmnSQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

oh steps to reproduce remove logitech headset

Additionally there seems to be an issue with correctly detecting the number
of audio channels.

the logitech is only showing up as a mono output device with the new
streaming code.

Grant.
