From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v9 3/4] ASoC: tda998x: add a codec to the
	HDMI transmitter
Date: Wed, 7 Jan 2015 17:34:50 +0000
Message-ID: <20150107173450.GC2634@sirena.org.uk>
References: <cover.1420628786.git.moinejf@free.fr>
 <23b36acc1f769418a06f3e929eba288b5911da12.1420628786.git.moinejf@free.fr>
 <54AD4C77.5000401@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3087035058244160773=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 14A6926508D
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 18:35:04 +0100 (CET)
In-Reply-To: <54AD4C77.5000401@arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Jackson <Andrew.Jackson@arm.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jyri Sarha <jsarha@ti.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3087035058244160773==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E4bwVoblQmO+UfRy"
Content-Disposition: inline


--E4bwVoblQmO+UfRy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2015 at 03:10:47PM +0000, Andrew Jackson wrote:
> On 01/07/15 10:51, Jean-Francois Moine wrote:
> > This patch adds a CODEC to the NXP TDA998x HDMI transmitter.
> >=20
> > The CODEC handles both I2S and S/PDIF inputs.

Please delete unneeded context from your messages, it makes it much
easier to find any new content you've added.

--E4bwVoblQmO+UfRy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrW45AAoJECTWi3JdVIfQYOYIAIBRRUG56ED979cEIDEh/gIN
C1/F6sbniZUcLBjliiKVo2rWZ6MZgzMzyNdlwTB5f1VN+0YwuPRn2ac23+cUqdDg
dqVbiGd6wYPEjnqyVC28cBg2x41CnZCcF3Qn7zbMO7q6lIsxH2QHhfl6/kviK1Co
y6PksCAD8bFgq+ux0pXVQCphl+1iMlbDKw2ykAM8iDszuz3mdsk02EmA/rmK1egO
5xbN+Y+nBxB/CWGem6TlseT3xAmXkD31O8ZCn9rauvuwoJKL0nthC6w1WZvo5ASn
PcPd6fWL2hB86nZdsBKc0LKvNjytepgbFWLjjgnDKYZ+dIEKI33j8ILMYc8UdOA=
=+QeS
-----END PGP SIGNATURE-----

--E4bwVoblQmO+UfRy--

--===============3087035058244160773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3087035058244160773==--
