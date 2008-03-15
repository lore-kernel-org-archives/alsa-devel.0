From: Rainer Zimmermann <mail@lightshed.de>
Subject: Re: Maya44 driver in the official ALSA tree
Date: Sat, 15 Mar 2008 08:06:50 +0100
Message-ID: <47DB758A.5090809@lightshed.de>
References: <f47256540802230203x234f458ak38a2312cab6cc2fb@mail.gmail.com>
	<s5h8x19uwev.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server9.dnshoster.de (server9.dnshoster.de [213.202.245.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 01F7D2462A
	for <alsa-devel@alsa-project.org>; Sat, 15 Mar 2008 08:06:34 +0100 (CET)
In-Reply-To: <s5h8x19uwev.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi Takashi,

Takashi Iwai wrote:
 >
 > Anyway, the Maya44 support is still pending.  We need some cleanups
 > before merting Maya44 support code.
 >

What cleanups in particular did you refer to?

As for the rate setting issue, what would you think about merging the Maya4=
4 =

code in its current state (i.e. working, stable, but certain invalid rate =

settings are possible), so testing can start, and resolving the rate issue =

afterwards?

Or would you prefer to fully resolve the rate setting issue before we merge=
 the =

maya44 code?


best regards,
-Rainer


-- =

Lightshed IT Services
L=F6fflerstr. 27, 22765 Hamburg, Germany * mail@lightshed.de * www.lightshe=
d.de
