From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: soc: atmel sam9g20_wm8731: remove useless include
Date: Tue, 6 Jan 2015 17:45:11 +0000
Message-ID: <20150106174511.GL2634@sirena.org.uk>
References: <1420536080-29181-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZElM7ipGqdpYifc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420536080-29181-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Bo Shen <voice.shen@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: alsa-devel@alsa-project.org


--YZElM7ipGqdpYifc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 06, 2015 at 10:21:20AM +0100, Alexandre Belloni wrote:
> A mach/ header is included but never used. Simply remove it.

Applied, like I say please do use subject lines matching the style for
the subsystem.

--YZElM7ipGqdpYifc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrB8mAAoJECTWi3JdVIfQcfwH/RbHc3HT2yXsp7bjTt4eCooZ
m7BTKd8CVmtTACNUcRuZK0a2RFXx7I36DrV1KlPBamZ2YaGJgHBWCbMmtKHUXZOm
3L+qH/4OYcObOjC7VsuwUcqym4vOsgqBgqbKN23+LLSuUFzJob9XfepSg+R5Fyih
D2mVsh7k+MqUahkAoXm8Dj+c6Jk+vjSk+GZwbJFvy6Cw44C85gTDHqCFJDU0huEY
TBaCpOicBOaLrIo1Z//GXHvP/pWQ8SI21NOiUdKmMYBLrThcSnYWzlagBduxXjW9
48RQUZ5QNLYV0Sql7+LayOFmlh0uP4OrUU6tQ/ehFXcwkZ6nOOAHcMyZV8ZoJ0U=
=94sL
-----END PGP SIGNATURE-----

--YZElM7ipGqdpYifc--
