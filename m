From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: rt5645: Remove unneeded goto in
 rt5645_i2c_probe
Date: Sat, 21 Jun 2014 11:31:41 +0100
Message-ID: <20140621103140.GT5099@sirena.org.uk>
References: <1402371356.16323.1.camel@phoenix>
 <1402371401.16323.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6827889240984435050=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A485265314
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 12:31:51 +0200 (CEST)
In-Reply-To: <1402371401.16323.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6827889240984435050==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XN1lL3NhKlxgwOIA"
Content-Disposition: inline


--XN1lL3NhKlxgwOIA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 10, 2014 at 11:36:41AM +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied, thanks.

--XN1lL3NhKlxgwOIA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpV8JAAoJELSic+t+oim9qsMP/2fDBhKvs6c39NfmNQGet5jT
Laeq7n4X3se4KnWmLl07p34yW29ml6jVN20EpFoXEdxtmu62Dq2GQWUJZSrK47aU
bGJ/VlDpAMDbRJTXHKhgISmp/IoOdOEaPKPD9/10j+yRc5Kr9EEApE1BCOLpdzMd
NaBqmDxHYjBVb8gw7MyRwP1sFxH2E/QRkRuSvJFP0nYOP6Ffk1+gv+aA4Uj4rnAS
eALDcFdXEvaz5QCX0fmXU0AdJisTofSYl0rZCPkkSh+bqhE4WW0YLxhn99kjyekN
1yQV2R9eUJzwOdvNDP3N3cVhC0IxKPkkx/yIicZVaC0h+x7rqqSng5EY+ABeYqMk
e3mO6GNzcpf8KyQUduf/zw+4Y0zHswBIkK82/f5EcPeQ4qVXLSnwY9Wr8pHQvyAT
vUPZ7LAmawTeTQdz22pZ0piO0RTQvWICn1tYFYaEJRPVSkHwvrfnmlDwTPCArm3x
6uZ04jlkJn01HCtad6gmaF5CxDe64cbSsOwgzzxbMe5oxRFUFkwwNACeH1zMcNdw
AHy3U5mUC1zDFpp1VHsyi42mIvD4qRLtfONxsxHPru0vOU3ZeADRsoi8x65Rn2rW
oxzQJjxSMmoozDUrB8HdeCHNUPMtOJZ1kziQ3KYqcosqH/oPk4rADRQBxohD/j/E
ilNwY46ukes0TKUSsJlq
=sG/T
-----END PGP SIGNATURE-----

--XN1lL3NhKlxgwOIA--

--===============6827889240984435050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6827889240984435050==--
