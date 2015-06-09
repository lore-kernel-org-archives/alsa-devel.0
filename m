From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rx51: Automatically disconnect
	non-connected pins
Date: Tue, 9 Jun 2015 18:57:57 +0100
Message-ID: <20150609175757.GS14071@sirena.org.uk>
References: <1433427231-21756-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2240856147704952445=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AC94261504
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 19:58:10 +0200 (CEST)
In-Reply-To: <1433427231-21756-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============2240856147704952445==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3tBQ62Qve5jUyRDo"
Content-Disposition: inline


--3tBQ62Qve5jUyRDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2015 at 04:13:51PM +0200, Lars-Peter Clausen wrote:
> According to the schematics the external speaker is differential, so the
> HPLCOM and HPRCOM pins of the CODEC should be connected to it.

Applied, thanks.

--3tBQ62Qve5jUyRDo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdyklAAoJECTWi3JdVIfQzTUH/R8jPllpTNTb6NCj3NXRW6F0
59beB4+Zxv6qsnlYyn6itdTIEx6y6WZiYiNpxSV124tjWT82xYUEP2t4uSd9/w4I
Qm2utcm9T9x8FZSgIWhM3hvpnhBVzmB+vjzXh+eL2aZsVaME3hPDYPKHubzXmV/A
6wwQSd6Gi0SBS+BPwJjWvAvFerg7VvdnZRN4YmoGn9lZ5Xn93UaYB3DhsJx2inru
GLhH7nOZawaMJ9QlFufLBcDBR84H5Cc83wac/v+PMXqlrBsaGUuzt/SvktewYNTA
MZuNiKPjlDgUF5Ljz/cyd9MNEX/VQjKaFOkPN4l88qXs+hGDD/SMIAhrMpqaqyY=
=T4x6
-----END PGP SIGNATURE-----

--3tBQ62Qve5jUyRDo--

--===============2240856147704952445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2240856147704952445==--
