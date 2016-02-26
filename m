From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH] ASoC: cs4271: add regulator
	consumer support
Date: Fri, 26 Feb 2016 11:46:05 +0900
Message-ID: <20160226024605.GJ18327@sirena.org.uk>
References: <1455635946-16267-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4464801359780382054=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C79AF2614D0
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 03:46:12 +0100 (CET)
In-Reply-To: <1455635946-16267-1-git-send-email-pascal.huerst@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: pascal.huerst@gmail.com
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============4464801359780382054==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3uZa4G/ShncPgKeZ"
Content-Disposition: inline


--3uZa4G/ShncPgKeZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 16, 2016 at 04:19:06PM +0100, pascal.huerst@gmail.com wrote:

> While at it, factored out the reset code into its own function.

Please split separate changes into separate patches.

--3uZa4G/ShncPgKeZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWz7xoAAoJECTWi3JdVIfQizYH/1iCFR9hzsAA0Gun8gMwb4Q6
1ar5VbD5DOtXU7PilOAmAeDa0CzCWbDSJLGVKUKH6VPFsUZa9+2vAFy33OioLptf
dChC2esyeXaKPwpjGIPAkxmTUM40y3hoq4Zn63Up02HjoMzkHgxMb0/9yLTxEpR4
/EITU3s45g5aSE5kCWyLbw2QEUpxLlZI66ZiWtfLJhmQ0PaIj5bdtC26r5CGaHTp
cx1ntKyrWNhoFoY/x0Z00PbO597V/llF1a4KcQeKWtFFfFN952OMwAz7A0yrDIhF
a/+Q8UrSFZwcuJR90c4wMZ0/WkID2VSiXuF0vXihLHgbWA2bmraJZ8oA+/uSra8=
=/Vz7
-----END PGP SIGNATURE-----

--3uZa4G/ShncPgKeZ--

--===============4464801359780382054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4464801359780382054==--
