From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: Hang up at .prepare( )
Date: Tue, 24 Jan 2012 20:30:17 +0900
Message-ID: <CANKRQnibHChSVEOvsDuKTXcnDkx5KQAMOxfheocTJt+ar0CgPw@mail.gmail.com>
References: <CANKRQngqJaAq7ucg3VzCMs+-KFXTSuJG=uq4d0kQ95gEMFfB4w@mail.gmail.com>
	<20120124105528.GA20519@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F2C461039EC
	for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2012 12:30:19 +0100 (CET)
Received: by pbaa7 with SMTP id a7so285446pba.38
	for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2012 03:30:17 -0800 (PST)
In-Reply-To: <20120124105528.GA20519@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

2012/1/24 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> What efforts have you made to debug this yourself? =A0Clearly this is not
> happening for other people, perhaps it is related to something you have
> in your drivers - have you addressed the issues raised with them?

I said previously, "our ASoC drivers" not others.
Of course, I understand current upstreamed drivers don't have this issue.
I just asked "If someone faced the same issue when debugging, let me
know about it."

thanks,
