From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Tue, 28 Sep 2004 16:48:51 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409281643130.1731@pnote.perex-int.cz>
References: <200409281113.i8SBDo5U021462@localhost.localdomain>
 <4159659B.2020702@pg.gda.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4159659B.2020702@pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?UTF-8?B?QWRhbSBUbGHFgmth?= <atlka@pg.gda.pl>
Cc: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 28 Sep 2004, Adam Tla=B3ka wrote:

> And placeing something in kernel (ALSA drivers I mean) should not break
> existing normal apps.

We don't break normal apps. You're referring mostly to commercial product=
=20
(OSS/Unix). The OSS code in Linux kernel does not offer functionality you=
=20
requested, too.

> I want to have possibility of doing cat file.wav > /dev/dsp
> and play it with 5.1 or 2 speakers or with headphones with special=20
> stereo  effects applied just by one click or keypress on special mixer=20
> app on the fly without restarting anything and fiddling with config=20
> files and program execution arguments.
> Current ALSA design is not user friendly and rather not meets these end=
=20
> user requirements. May be it should be only for audio profs?

Help us. I have all those ideas in my brain, but they are not implemented=
=20
due lack of time. Crying - that something is not implemented - will not=20
help us at all.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
