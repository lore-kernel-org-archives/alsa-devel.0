From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: care audio local bus data
	format consistency
Date: Thu, 31 Jul 2014 20:37:03 +0100
Message-ID: <20140731193702.GR17528@sirena.org.uk>
References: <87egx2uijb.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7820435910773790442=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 97035261A81
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 21:37:11 +0200 (CEST)
In-Reply-To: <87egx2uijb.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Jun Watanabe <jun.watanabe.ue@renesas.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============7820435910773790442==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kqd38pRE59fk0lc2"
Content-Disposition: inline


--Kqd38pRE59fk0lc2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2014 at 11:52:26PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> R-Car sound uses Audio Local Bus which uses Lch/Rch format.
> This bus is used if driver uses BUSIF.

Applied, thanks.

--Kqd38pRE59fk0lc2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2prbAAoJELSic+t+oim9k2wP/i829t5hgayUdNbmU0j73sQO
nv68W2mpgSSR57BzdMHOBynmbdBpXYXsZFPFRU1K1aw4EiXQMXWCsfDRyg+I/cXj
1f+i+0iyZHp0sAh0RlI+fmEDQC13tmqHpluwbcDMbuLCDUEVIOT54D/JR5U2PNKi
SBemM3smLdpS/PA7+nvPgDveQz1J/BG35hDaeg2tT9unNORctdBRuDieL7u/tNDi
CYfywuk+PBYFazkjibRrKrm6bV20EyS1Tk+vnIIHAEPw5ZF8Klb8DDNr1SQ/hcQc
X0PiSXhbuaz0Z3XFnfe6Ou5Abbu0K2DcGYqLH5sXVheoFRnJ5PkOEliJGJjJ5Tu+
sYMsM3wy3KV8y6Gau1oUu/2IIfxO+aFTJ4fwYwijsIn6i1jvEAFH+r0JWLqTq4yy
95XTJwWMFP7zMIiBQ4CRf23woFMey+Zkg8mKifINL1Uys+TkQIuantUdTpyadKC3
9ZXLBCWIugG1v+MQlBP8ihmpo/Zjw9a+FHPZsN/doVOK6IqQosPuWn0G4Un4ntIM
2r/nG7Dh18djOWWlNmEfUKEH8m2nIvANrqZvLxmcuFB3KH8OQlSv6Om+XJ45N/tC
+GAP670suX2DazA7C/wlmKdNum4rTzN8QRMf88EDVR3BuCtcZerFJpnBCE7koVx9
48gUqthcceBEv25F+nKb
=R7xj
-----END PGP SIGNATURE-----

--Kqd38pRE59fk0lc2--

--===============7820435910773790442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7820435910773790442==--
