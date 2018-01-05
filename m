From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7] ASoC: TSCS42xx: Add support for Tempo
 Semiconductor's TSCS42xx audio CODEC
Date: Fri, 5 Jan 2018 12:38:03 +0000
Message-ID: <20180105123803.GD9076@sirena.org.uk>
References: <20171219205415.wlu4atv2mdy7i3gb@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9091247203223781165=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CECE267A16
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 13:38:06 +0100 (CET)
In-Reply-To: <20171219205415.wlu4atv2mdy7i3gb@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Philippe Ombredanne <pombredanne@nexb.com>
List-Id: alsa-devel@alsa-project.org


--===============9091247203223781165==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 02:54:25PM -0600, Steven Eckhoff wrote:
> Currently there is no support for TSCS42xx audio CODECs.
>=20
> Add support for TSCS42xx audio CODECs.

This doesn't apply cleanly against current code, what did you submit
against?  :(  These aren't trivial things that have just been added to
my tree in this development cycle either, it looks like you're
submitting against some older kernel.  I've applied anyway but please be
careful.

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpPcaoACgkQJNaLcl1U
h9C/uAf/f7zxEUprNCXNxDht+ujYRmJgRLxUqx+24wj7eOWPxrOgivw4IFYoP2Wj
EBdIrdpmtOtrMV53ineqLwbDYW1pfryM77ybv5+1MYDinNdGsI0dtSUCzQjNGsGj
efk5eW0YJQNgVGCDt8yjIuNTWle9a0bYhqy4Ns+EwtBc1X3HSlgPfxkqz3CgMviB
RvqtD0zObqmgRqSIAaP6fmmxXnQFIaymgqMOtkhsJaVW6kj/ArEi3SzNLBeGWBrr
vPL/Dmp8CoKkRuWm9nWyPqvuW08lrKtN/txq8uCKJjDidc7tAmtTKHxLEUqchguf
Y8givkvAq2R8G30lgkWi1pPNMosowQ==
=N5Xc
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--

--===============9091247203223781165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9091247203223781165==--
