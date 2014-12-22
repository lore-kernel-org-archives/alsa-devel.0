From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add I2C dependency to two new
	machines
Date: Mon, 22 Dec 2014 12:21:01 +0000
Message-ID: <20141222122101.GI17800@sirena.org.uk>
References: <1418913635-7422-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1420115030141458215=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3408A26068B
 for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2014 13:21:26 +0100 (CET)
In-Reply-To: <1418913635-7422-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@intel.com>, alsa-devel@alsa-project.org, Randy Dunlap <rdunlap@infradead.org>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1420115030141458215==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1E1Oui4vdubnXi3o"
Content-Disposition: inline


--1E1Oui4vdubnXi3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 18, 2014 at 04:40:35PM +0200, Jarkko Nikula wrote:
> Fix following build error when CONFIG_I2C is not enabled:

Applied, thanks.

--1E1Oui4vdubnXi3o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmAysAAoJECTWi3JdVIfQUGAH/RolWTOCcZkAozNmvJ5FC4f+
4le2k1aGUePUxkqx5WdUxCpZ1X0Ej8tB2l2s8Pu1x3QtM+9HvWNFEQ3Q/X13GJU9
b2exMmv7ONb170fllUkuxuJzUX3PJPRqlw236zILGBkuixYS6F03ibAiyjh9kD0U
2Lk8E+JByYIw+125rldgLVdXQhmjToLr17fNkg4Y8p3lrPs7Du/mHqnTjh27aQh4
NJWB9uzBteONsKcMW2vgKju1/6vKPm13XaQtAd5InMf5LVD8teHf8/0z8c/66erb
XTXdeAmmmQX9F3ieYMy7qO6AfKhNCjCyuzvFe+k/IKExa6bEyaMMbFqxCp8bX3o=
=vdAE
-----END PGP SIGNATURE-----

--1E1Oui4vdubnXi3o--

--===============1420115030141458215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1420115030141458215==--
