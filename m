From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: kirkwood: Fix compile error due to
 patch 'add S/PDIF support'
Date: Fri, 25 Oct 2013 09:13:08 +0100
Message-ID: <20131025081308.GJ18506@sirena.org.uk>
References: <20131024175518.49b80343@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3660326659517815267=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B594264FB0
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 10:13:26 +0200 (CEST)
In-Reply-To: <20131024175518.49b80343@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Liam Girdwood <lgirdwood@gmail.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3660326659517815267==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yr/DzoowOgTDcSCF"
Content-Disposition: inline


--yr/DzoowOgTDcSCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2013 at 05:55:18PM +0200, Jean-Francois Moine wrote:
> This patch fixes the compilation error of kirkwood-i2s.c introduced
> by the commit 75b9b65ee5a80e99e 'ASoC: kirkwood: add S/PDIF support'.

Applied, thanks.

--yr/DzoowOgTDcSCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaigLAAoJELSic+t+oim9k8gP/RJneupK6Q9xls6Z6q3rfURP
6mQqUfkZtewkIg2tYoHCeajOqxzw+H5iWxalMK0r1Hz/GBpNBBpGxSgZz/snsMrA
YbSX8bfmTPzSkJWeCRsW6W00suKa78hP4X2JaovxKsVs4PvlpKcmGh82s0uXKn63
CYFkm5LbW1sRXsJtu9zaAmPebswNXukPRairkDcSgZ5y4Yvpl1L+8ETKZmh2zKXD
9fr9A5cvmJrV5YpGih0TvV7fphZcCuBmh5Vn2iR93QKh9MHOWNLQ1mcjVcYck2rj
eHZfU6N1r6npkBGGdSrF4U1IKGEZ4eZMuXMPSslChT223uqAmYdwJbmCKhgFV4tz
qfSTTzw3YPIusr5RBbqvFXHoEtdwWT3b0wOoIjOykU1bDPObpAQ6Bjo96CmSQGmi
T8SG6omLjGFPm720pL7ZsjW3UY1B36XcHQNEVjtl8WmHhBitDbkwgEezP5/BA5sT
SEtauYmnl2P4w3zf1GkRh4CZBNaYF76Z3GJBjI7N8Z9Q3lfMCNKRLVRfs7w4h/Sl
zeAnmVUezX09nI38DoZzt+jSh2XSHDOmfxxBT2yQtYOihRvGFNsjBTdqMucAVjM0
m/tdc2YSUuy5YdbgzlUTz5iLfUz0kUwemPPNRShHfW0PTCUqSFS4WiU2+UiN65ma
H5tvnYdES7UlaadMkfcS
=eMw0
-----END PGP SIGNATURE-----

--yr/DzoowOgTDcSCF--

--===============3660326659517815267==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3660326659517815267==--
