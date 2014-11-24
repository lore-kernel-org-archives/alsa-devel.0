From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: max98090: Fix right sidetone
	connection
Date: Mon, 24 Nov 2014 17:14:44 +0000
Message-ID: <20141124171444.GK7712@sirena.org.uk>
References: <1416835957-14153-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1416835957-14153-3-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6560620458298157319=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 02BE52650FE
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 18:16:46 +0100 (CET)
In-Reply-To: <1416835957-14153-3-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6560620458298157319==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2WS97oupGEGbYNpW"
Content-Disposition: inline


--2WS97oupGEGbYNpW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 24, 2014 at 03:32:37PM +0200, Jarkko Nikula wrote:
> It is right not left sidetone which goes to "DACR".

Applied, thanks.

--2WS97oupGEGbYNpW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc2eDAAoJECTWi3JdVIfQUX4H/3n6eK5Uo0+rHh6joxMNZV5B
29eVsvw328yV7qIALCFUg33lx5q8yEsKrIvChwqzrW/wRPLHDaiVfhh779JtvVMO
UDokRf9tdlmtYkM0A7b/HQZJY3FImi3VfrTkyz5PnuaC/VISfoQR0VB8NjZqpeQ7
FJ3m/vWHRKznjoJbM6nYdtnKBhnJ6G3enSpJFjSwVxcfAD2RgvghgDUnfZfHgTUD
38Hkx8HkQAs7bMhCPhZZ5uqgC6iPDKtCC3iq3IKWqRLvt0wbnn7zGy7SavRqN5BL
/zloi2rV+vKpjeHBztJiDESI9CIrme7eDSaKLdKd2g6+hJFiT1i/LqN09F5VthA=
=pJVR
-----END PGP SIGNATURE-----

--2WS97oupGEGbYNpW--

--===============6560620458298157319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6560620458298157319==--
