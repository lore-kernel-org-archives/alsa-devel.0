From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: Remove const attribute from
 lm49453's snd_soc_dai_driver
Date: Wed, 27 Jun 2012 12:11:21 +0100
Message-ID: <20120627111120.GC308@opensource.wolfsonmicro.com>
References: <1340782476-5626-1-git-send-email-zonque@gmail.com>
	<20120627101751.GA308@opensource.wolfsonmicro.com>
	<s5hwr2trqzd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5200462828895838360=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4109A244A3
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 13:11:23 +0200 (CEST)
In-Reply-To: <s5hwr2trqzd.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, mr.swami.reddy@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5200462828895838360==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 27, 2012 at 12:25:43PM +0200, Takashi Iwai wrote:

> Could you put it in the next pull request?
> It's not fixed in the upstream yet.

It's fixed in -next, not in for-3.5.  I guess I'll pick the change over
at some point.

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6upSAAoJEBus8iNuMP3deuMQAJ1rlBVCPTsNXJDo8YKgkFG8
67yypMG6u/tbxZAm8L1pJTzk5UrbfySgxvbgnEtuuoQ3jjlXVnVB1Ocd1qRhxpJ+
JxwEZugDeud/u6I+VTaNN+KGDALQ0k2s+EUPzWLYwZB41hOUwuIFIFSSw1gbXDon
edMpRS/kjLC2xAB4Dh/z4+wQuhHeKTpxi3D2WK7XoT679U6OdxaHDmyDJJ1mqLZe
0HzIHGGyxkcCC7TKc9IIf+O5vXU7+l8eTUOvlBxtn00zEslnz6NcaS9q0+b/njPB
9tcmdMUFnVBgUKC4ZPi3lLY7ETt/8GYFdoJV9+ioKG1nUfA0LRravuX1DxTkgHg/
nx5U0haXrXcd7RDt5E0PZOsf2ic6NdJqaLSXjWGOM/M1BqSd4Jzevg7KTmAsMLOF
tpkmkuspByzNk8/Uzss9qevkXgIuHZYf0Xi5i1vkW2eAXUmSdiaD6qr+jM43uZt9
LadtReGujtvuX6DpIZ6LYmq4asi08zwBh/9t1Sr81TZQT1FMj//bOz3V7bVQn7tk
KJxjl6F0eVDCkAMkLMdV+jPyLGFKLmd6W3U/eq49OwKhHYBgmCnyXybwDyZPtoCL
zmSMNijAcK/UvJg1N7zoolBBrjeRpvKDQla7ZQfMTt0UQEArhSV5kuYTBKSKG+ZN
c95tLqKasWqf/kcSQiTl
=Dj4D
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--

--===============5200462828895838360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5200462828895838360==--
