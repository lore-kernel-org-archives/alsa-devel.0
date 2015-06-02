From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8731: initialize the hardware when
 loading the codec driver; use regmap for I/O
Date: Tue, 2 Jun 2015 21:12:55 +0100
Message-ID: <20150602201255.GS14071@sirena.org.uk>
References: <20150530003455.4c4d67eb444b1ceb45d3148c@intel.com>
 <556C1FCD.1070905@metafoo.de>
 <20150602113318.918151bd4112a407da314099@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0320110738721659966=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A6459260523
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 22:13:02 +0200 (CEST)
In-Reply-To: <20150602113318.918151bd4112a407da314099@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergey Kiselev <sergey.kiselev@intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============0320110738721659966==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UEgmpZn7Z/frN9Sq"
Content-Disposition: inline


--UEgmpZn7Z/frN9Sq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2015 at 11:33:18AM -0700, Sergey Kiselev wrote:
> Hi,
>=20
> I generated a new patch that fixes the issues indicated by Lars.

Don't top post, and if you want me to review this patch you're going to
need to send it as covered in SubmittingPatches.

--UEgmpZn7Z/frN9Sq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbg5GAAoJECTWi3JdVIfQwysH+wbR2auziQZrgSCPl0ZBkCUU
VhXpumJ08YC+YoXuE2qQNhL9cQBfUQ7toU/AZdioM0zpSRwoUmaJpMi+6NOOzud7
bYz25AqtVPNnM8YlFzjx1TS+34VfFw0YjFv4FOC/4hLd+G/Q0TlGi0xMrIduCzMn
99mSjA86a36aNoP5QKutLtZh/4b2CQOtjWE0Z1p5EXdHfVJX6plZP2tfOhzlVx7d
tHoAlP2+l5quiqWeVUj8hGUM9wxqM6tg0Oelm/NALyNacKRMV7R2q5yW6ahtOL5M
KXnorQImjztuFTDlOpCtu15XIiZ+K6CKbRadfwq1ArjHrbzDtm4pFMOHEQbqBrw=
=dRdk
-----END PGP SIGNATURE-----

--UEgmpZn7Z/frN9Sq--

--===============0320110738721659966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0320110738721659966==--
