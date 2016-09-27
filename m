From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: arizona: Add debug prints for
 output power up/down times
Date: Tue, 27 Sep 2016 09:04:26 -0700
Message-ID: <20160927160426.oq732bocrykujwoi@sirena.org.uk>
References: <1474990545-29282-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8030461745232411597=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8983B266552
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 18:04:41 +0200 (CEST)
In-Reply-To: <1474990545-29282-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8030461745232411597==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gn3swbjnhcepstxs"
Content-Disposition: inline


--gn3swbjnhcepstxs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 27, 2016 at 04:35:44PM +0100, Charles Keepax wrote:
> When debugging it is useful to check the total power up/down delay that
> is executed as part of the coalesced output delay. This patch adds some
> debug prints for this.

This doesn't apply against current code, please check and resend.

--gn3swbjnhcepstxs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX6piKAAoJECTWi3JdVIfQhswH/jJCbDBkVGSNyiWaTvZ/Fx0k
NyiPjTnsneC5zhPheH5bFnZ8unGO8OCZklzMWwnV7IQgXI5eLtJWW2sj2y9j1bbe
gW36wE5AEb28wdziyFgT0X/yi6L3eYAdjWv6eo1spLNws+hsxbYAAXAorQVMhuH8
RO13k0od5DarMRSD3U7VZYuhrh+qBCwvwLNKIQPQFTtcoHve2oY/ptuIOuEXsXlZ
76mZQ73PLz16yY7wJVwWuRbroOOMr2HzKpsYXO1ZWev6JbeTrILNFdJ03MTLksXK
RKBBtq6qCC+l1THocfI1QPa66Y95JdJ3xIxrM+YQKwI118sWv7G4K4rwWPkqtUo=
=Egb2
-----END PGP SIGNATURE-----

--gn3swbjnhcepstxs--

--===============8030461745232411597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8030461745232411597==--
