From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/3] Calculate BCLK using TDM slots and
 remove channels rule
Date: Thu, 30 Apr 2015 20:47:42 +0100
Message-ID: <20150430194742.GF22845@sirena.org.uk>
References: <cover.1429794271.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1536321215172559722=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BBB952607C8
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 21:47:48 +0200 (CEST)
In-Reply-To: <cover.1429794271.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1536321215172559722==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2xQ++RZVvX2PkXx5"
Content-Disposition: inline


--2xQ++RZVvX2PkXx5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2015 at 04:16:03PM +0300, Jyri Sarha wrote:
> The first and the last patch are excatly the same as in the first
> series, but in the middle thee is a new patch to constraint out
> unsupported channel counts in multiple serializers case.

Applied all, thanks.

--2xQ++RZVvX2PkXx5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQobdAAoJECTWi3JdVIfQ1pYIAIcEe/bV4V1gJM3Oj1WARlo0
RlN1EFTD1+r2S8Jh98Zw0MbPwgSUk+gzciI4MnY9kM5+kN9Db+zCWG7k2Sd8cbcP
t5iucmQHHrnXFi7HxeOgyHeghC8efVV0LvmwXSpdGwnAJAjotMX9KMG/0vw6X6Xq
18LvafvvBUVyg7NAa+S2gbIDpGGCWv9DB+HFBzfx7VAO0fb2QC7M5Qczwa1HdXrC
JiAJkGOMVu9WdkNUTRp2bsyFl29Z7t6zNb2JY7gfUSjSLqCfTl+tN7EqTY8wHVRF
bBMnY+/CqxOUOGgyraVqBZ6jyzi/miOwe0zRf4QlGL7uVbekRv1YDzxdlSpf8lE=
=d/sX
-----END PGP SIGNATURE-----

--2xQ++RZVvX2PkXx5--

--===============1536321215172559722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1536321215172559722==--
