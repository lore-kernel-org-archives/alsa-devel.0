From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [asoc:topic/atmel 7/7] ERROR: Input tree has
 errors, aborting (use -f to force output)
Date: Tue, 6 Nov 2012 12:12:47 +0100
Message-ID: <20121106111246.GA10080@opensource.wolfsonmicro.com>
References: <5098e341.O6MhFjJV2ViFIEza%yuanhan.liu@linux.intel.com>
 <20121106105856.GA17982@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3302978572267443429=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CAA1526172A
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2012 12:12:59 +0100 (CET)
In-Reply-To: <20121106105856.GA17982@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: alsa-devel@alsa-project.org, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org


--===============3302978572267443429==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 06, 2012 at 06:58:56PM +0800, Fengguang Wu wrote:

> ERROR (duplicate_label): Duplicate label 'ssc0' on /ahb/apb/ssc@fffa0000 and /ahb/apb/ssc@fff9c000
> ERROR: Input tree has errors, aborting (use -f to force output)

Reverted.

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmPCdAAoJELSic+t+oim9cEcP/33YzmhL7S2Ru+UzhDpKVJn0
/GbO/G3WBjNTXhSGvS0M8a1SxRdKdVUB3/JFHpJ3tGLv3K7sYECS0miUTw2twTFT
Y+7Rvpp7jK2t+C0mIOmlQhGjoWF1aXDrgycK+jfh5W0yQ+Gw0K5kFM0D2WooYaqZ
E5L99++yV7IZ9DbfrzN84OyDn50gsz9ym8F8P8KA+EorickWNYZUjFFJNd+Jd/db
cAGVI2468/a0zFesaWvMqXdfw/XzNzdZuEa+6sgSGG95Po4YeFCoG0ufobCRMyQJ
u6AT/leLyFjJ+ZPcO43YbXpL1nQ5aX1x1FlTX9d01BKw37AnkKdnXXBQbydkEvWt
REHqU3JL9ZUZF6fOoL4yDkNtUDIu3p4aLGSzdPvJJQB+yoQZHhrHYKlFYtlVqwU9
tYyfZLiLWQ6C8Fuhnv6Db2o6JVNvpvcufN34DtoZMU8FRtGsjsO2x7pSt1rbq6La
dHMjGu/IRRzpECJi4/UjHucHHhSGPfW5fPW7rgTyJpIcNOU/dBOBZMu//oFbzenW
WQl8kAwtqMuDHh5J0rQuE1CKeOUyZVmy8Xmdx7qfwuHejVjaORP8BA/xe8umRHRM
tujCkTIktr+RDA1K/Oevll/GqE1k2N0lCWYKb1yRVK9vIOU84rKVmj1WwQp1/EuX
urBZtQCvlwfsfdE8y9VC
=/6Nv
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

--===============3302978572267443429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3302978572267443429==--
