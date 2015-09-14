From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/10] ALSA: axd: add buffers manipulation files
Date: Mon, 14 Sep 2015 19:50:29 +0100
Message-ID: <20150914185029.GI12027@sirena.org.uk>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-6-git-send-email-qais.yousef@imgtec.com>
 <20150826184323.GE28760@sirena.org.uk>
 <55DF1CDD.6040109@imgtec.com>
 <20150829094711.GZ12027@sirena.org.uk>
 <55E5774A.8070808@imgtec.com>
 <20150903123232.GX12027@sirena.org.uk>
 <55F68F5E.3050609@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8FceN5h68k46+V7B"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55F68F5E.3050609@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--8FceN5h68k46+V7B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 14, 2015 at 10:11:58AM +0100, Qais Yousef wrote:

> I didn't write an rproc driver before, if there's anything that you think I
> need to be aware of when writing an rproc based *ALSA* driver I'd appreciate
> pointing it out.

I'm not aware of anything, the biggest driver currently communicating
with a DSP is the Intel one.

--8FceN5h68k46+V7B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV9xb0AAoJECTWi3JdVIfQxGAH/0YCRbOrsidsOIhqp8o5qsTE
BenG+iGmW5GfTh3mTc980gxkwHx0st9KzfovCBVwRiQv7+e8KC72guDXtcRHXq3v
PGZpb8hKDD4eczkt6JvmHdM0fPpUx+PYFh1RTP5+V+tddCZdSBr2zm/vTE9A3KOS
cICvi1YNzihOwkdu+ua1xdZryhfT2TyFTPBodcZV4q01BjHPnOmevQoHOTiJqV2l
DcdhU+XK44+T13Az7ckbHleGCZ4OtqDHuxcOPc07JmQ4Vadl+E+ah+0oPbQJhIoB
X6KUOoeK2B/MiuC3AyAvELV8UG0guACcTLas9YVkxX6HMrColABD2anVwSGdvDc=
=UDig
-----END PGP SIGNATURE-----

--8FceN5h68k46+V7B--
