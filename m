From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: set the same format for dac
	and adc
Date: Thu, 15 Jan 2015 11:16:24 +0000
Message-ID: <20150115111624.GR3043@sirena.org.uk>
References: <1421290165-20724-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1267326599141322223=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AF7326046B
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 12:16:32 +0100 (CET)
In-Reply-To: <1421290165-20724-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com, omair.m.abdullah@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1267326599141322223==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y2MHPAl/EzyWgzIZ"
Content-Disposition: inline


--y2MHPAl/EzyWgzIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 15, 2015 at 10:49:25AM +0800, Bard Liao wrote:
> There is only one I2S I/F, AD/DA path must operate to the same
> format.

Applied, thanks.

--y2MHPAl/EzyWgzIZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUt6GIAAoJECTWi3JdVIfQGz4H/A0zxKfJ3FoYbdFsFpFVIj/h
9MWz+k7w8zPgDARhm2OHZgPZK7Md26x5ZoDt2VN86L5cS4TxY6j7tWkdeUVr9777
+hjjmlCpTV0W8E1U9zAKRDj/OxtfIkVpzNrFEtitYAxt3tnsyym3IdfKla+C8yRW
2pWLkcu7Ks6L6sFHlRXS1HcP8gCun5jkLfdTFwJi80HGu4hb3w/WMBJwxqKV1qJl
YV3pFMkfckaRjB5vqjzKWREz+82cZG9euO6DpSeLimQCa9r6rzqPkRiyeQcrzFcE
tfBt74uIy/l0TDS/Xv6QjFNJtlhpTTLSJvcfqZwbHSRAR877sYpWV+mhsPTFwRE=
=KzS7
-----END PGP SIGNATURE-----

--y2MHPAl/EzyWgzIZ--

--===============1267326599141322223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1267326599141322223==--
