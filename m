From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: davicni-mcasp: Mark the common
 irq line as shared
Date: Mon, 2 Feb 2015 18:32:53 +0000
Message-ID: <20150202183253.GV21293@sirena.org.uk>
References: <1422880713-25414-1-git-send-email-peter.ujfalusi@ti.com>
 <1422880713-25414-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2080243226170378160=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A096260575
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 19:33:02 +0100 (CET)
In-Reply-To: <1422880713-25414-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org


--===============2080243226170378160==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yqH4HOlpOrgjBzwY"
Content-Disposition: inline


--yqH4HOlpOrgjBzwY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 02, 2015 at 02:38:32PM +0200, Peter Ujfalusi wrote:
> On DA830 devices McASP0,1 and 2 shares a single combined interrupt request
> line.

Applied, thanks.

--yqH4HOlpOrgjBzwY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUz8LUAAoJECTWi3JdVIfQlSgH/11F+25vo12md73VW7Nz7OOW
B1Ss0jxFOpwgawhDvwZkGrRaAaOqZaeHMVCMer2SwEcTbUMmEeIYFFUguHTtK2tP
QNFkNIc9WmUzaAdNWklprHhHsvVjItIBLDbEX8MHTVJ0aD6/uAtyDjM2d3VhDfQy
xnvH5oS894SQiUdbdl9FN/IMM9P0Ng+O0GTD7ICDV3vBkowHh825Eh8AiIcDzwEs
/iCoCpx5uLZiuONfXzNLL7BxefWAEizvLpxoHEZAO3ECjOcQ4XSFjW1FSgcBwp+Z
6dCjoSMATksXNmpqPV3CvG3El6FrYTzuECiSLAauvlx23dEMPTRnYLaqkBrYrs8=
=3a5F
-----END PGP SIGNATURE-----

--yqH4HOlpOrgjBzwY--

--===============2080243226170378160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2080243226170378160==--
