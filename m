From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add api to retrieve dmic array info
 from coreboot nhlt
Date: Thu, 19 May 2016 17:01:36 +0100
Message-ID: <20160519160136.GE8206@sirena.org.uk>
References: <ac23a9ba3795ed50bea2d88dc90b419238ef1542.1463673471.git.yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0589043057622750628=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CDB4D260647
 for <alsa-devel@alsa-project.org>; Thu, 19 May 2016 18:01:44 +0200 (CEST)
In-Reply-To: <ac23a9ba3795ed50bea2d88dc90b419238ef1542.1463673471.git.yong.zhi@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yong Zhi <yong.zhi@intel.com>
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, marc.herbert@intel.com, yang.a.fang@intel.com, sathya.prakash.m.r@intel.com, jeeja.kp@intel.com, vedang.patel@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0589043057622750628==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Content-Disposition: inline


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 19, 2016 at 08:58:59AM -0700, Yong Zhi wrote:
> skylake can be configured with either both 2 and 4 channel DMIC
> array, or 2 channel DMIC array only, this patch provides an API to
> retrieve the DMIC info from nhlt.

What's the difference between this and the similarly titled patch you
sent yesterday?

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXPeNfAAoJECTWi3JdVIfQu7UH/2B54LP2TKD4mJWHihLysH7S
L4hJl80LKQPKjXAb/0IztwdAVtQ6MWEkVdD1yETVwEN13d3k5qIm25INRMzjyjLZ
wZPAPFOAoOzV1qqf+aot0r1FdsGVQae0Y4t5RhZwNOEsgaJMRKaFSufvORNuaeor
ffn/CfObTCzs3BhcwcDjxaq2J8jnggaciTQKGrCHnRt/RtE47NRMfYCEekqey/Ch
e9RSuAwJ5OOn/5ZJ2Dej7z9Z0u2JsCizwvMgygHFdhfuQPmbllASFef0A8JcA2TT
s89aPiNWIKkprFlsAwqsBcgaTZhvBRv0HPKylQDVQ7yG1dGk5evD+3+Fj0HDlZg=
=KeZ4
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--

--===============0589043057622750628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0589043057622750628==--
