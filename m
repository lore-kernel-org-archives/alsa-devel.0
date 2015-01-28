From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH PING] ASoC: dwc: Remove unnecessary
 conditional compilation
Date: Wed, 28 Jan 2015 17:39:54 +0000
Message-ID: <20150128173954.GC21293@sirena.org.uk>
References: <1422391108-9011-1-git-send-email-andrew.jackson@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7354280484392997416=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3282126262D
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 18:40:07 +0100 (CET)
In-Reply-To: <1422391108-9011-1-git-send-email-andrew.jackson@arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Jackson <andrew.jackson@arm.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liviu Dudau <Liviu.Dudau@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7354280484392997416==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HxY/eTLWEtH+OqMc"
Content-Disposition: inline


--HxY/eTLWEtH+OqMc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2015 at 08:38:28PM +0000, Andrew Jackson wrote:
> From: Andrew Jackson <Andrew.Jackson@arm.com>
>=20
> of_match_ptr is already conditionally compiled based on

Applied, thanks.

--HxY/eTLWEtH+OqMc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyR7pAAoJECTWi3JdVIfQMvsH/1ug1zYiuWFcNDLdhDyYuwu0
1sCdCBvkQHtMvzxAWf99dGOecmIDMvbLXy5b9/mPBGyj1hROJDWjH5QbQuA3DXWI
HiLbCRE4iDZbSHla86QwzmJ11dNvyRFrMjExPr+5jXKXreuonukrrqCkhcQGi9Nw
D2w1tNxnoUS2+NLPoEnWzabv8vgJyVZRIS8SpgiQW0r3MqX2CQog4/HISGWQAO0T
cXkpohqR1CeLs0qXmLMF+Zv21aAXqu/BF2alTYKxPGEe4i9SlDsFZaYqGCyY12J0
sOc40Uq4UYI/RZUBYImkEjVsy7gCQeXj/4zj2Pj28eBqGrcSZw8+2sic/hEduGs=
=U0xS
-----END PGP SIGNATURE-----

--HxY/eTLWEtH+OqMc--

--===============7354280484392997416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7354280484392997416==--
