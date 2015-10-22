From: Mark Brown <broonie@kernel.org>
Subject: Re: DP hotplug on USB C
Date: Fri, 23 Oct 2015 02:14:17 +0900
Message-ID: <20151022171417.GC29919@sirena.org.uk>
References: <1444657786.2528.78.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7545408388552918027=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D6CE2266AD9
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:34:54 +0200 (CEST)
In-Reply-To: <1444657786.2528.78.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============7545408388552918027==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 12, 2015 at 02:49:46PM +0100, Liam Girdwood wrote:

> HDA/gfx: relevant people not in room.
> =====================================
>  - Pierre: Hotplug DP over USB C required. Needs input from GFX folks.

Not just display people either, there's a bunch of core infrastructure
needed for handling USB C before we get onto any particular functions.
There's some people looking at it but it's not clear that they're
working together or heading towards mainline yet.

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKRloAAoJECTWi3JdVIfQpL0IAIPcAHm/rdrx2IWOeKWZpcJL
FLptDdaSxAol4yFgmsSLiITIEg1Qt3bxsYStKMnmbe+vRKAAGnEr6wmdJhVeUzQj
SGcH8oKYfCx3spotS+/HsRtdnPwuolhvmUS2/up1t/kkwUHkqpyVWi/jG4MNHI2/
ioL082ampgxIVzwW8neucv7MjWD2dBnv2Q25xlCb/u53C2gLOkjZ3+znS7vl5Br8
/YGOtnMMbvSDMpx5BA0FHgONmqg5ltzKFMlBpS1v6LmtZ63aAoqkKQtVcgyxazxk
J+scu1gxfduFssnoewCFV+QNK/nJBHukd3an1HPUPlBYWA+cUGmOGWkdZcaCdQI=
=y5f3
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--

--===============7545408388552918027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7545408388552918027==--
