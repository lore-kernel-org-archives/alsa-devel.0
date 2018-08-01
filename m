From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 1/8] ASoC: Intel: Skylake: extend widget
	handling
Date: Wed, 1 Aug 2018 10:47:44 +0100
Message-ID: <20180801094744.GC5509@sirena.org.uk>
References: <20180727230554.31027-1-pierre-louis.bossart@linux.intel.com>
 <20180727230554.31027-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2550209997041046956=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C17C02677BC
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 11:47:54 +0200 (CEST)
In-Reply-To: <20180727230554.31027-2-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2550209997041046956==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 06:05:47PM -0500, Pierre-Louis Bossart wrote:
> From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
>=20
> include DAPM Mux and output widgets into the list.

Please don't resubmit patches that have already been applied, you should
submit patches against current code in the tree you're expecting things
to be applied to.  If any updates are needed to a patch that's already
been applied you should submit incremental patches which make those
updates.  This avoids having to change published git commits which could
cause problems for people working against git.

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlthgb8ACgkQJNaLcl1U
h9AjuAf/RDP7h00BNqReCNXsm5iNHw4aElgtPN+v9x1BRq606Af3GSzRQXWbj9Pr
O0mVYL5aHFJFQ7qUA91KK+bxjhXHq1I+rkCcNUaih67cE7F5E0YbKLpMQggLboRh
+QYZA0DHMyoobETtFH+bQiGZrnTE9X59wy2Jhv+o7g58dytUG8ViSB0GTIq4KEKF
l3blyKp3Rbeszr2dWz3IFpEZXdxXD/EQKojzzAMzmnwPsnNHhOlOGiEdFDsBAmhv
nNjsTGKv5YLFe1RkqetyFBBgkpUqsLkWAu5ipFX7/5XeuFLuHi3x3zhoPsuGIwhd
acM7RR7dRAEjuu1kzFJ5bnBxEKU+uA==
=bYeT
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--

--===============2550209997041046956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2550209997041046956==--
