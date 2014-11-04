From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/8] ASoC: rsnd: Add Volume Ramp support
Date: Tue, 4 Nov 2014 11:45:41 +0000
Message-ID: <20141104114541.GL3815@sirena.org.uk>
References: <8761fc7vpx.wl%kuninori.morimoto.gx@gmail.com>
 <87tx2w6h2r.wl%kuninori.morimoto.gx@gmail.com>
 <20141028223814.GM18557@sirena.org.uk>
 <87oasviuw0.wl%kuninori.morimoto.gx@gmail.com>
 <20141029225659.GS18557@sirena.org.uk>
 <87r3xqxf1z.wl%kuninori.morimoto.gx@gmail.com>
 <20141031115330.GN18557@sirena.org.uk>
 <87389zakvi.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4528017083782474328=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0131626060F
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 12:46:55 +0100 (CET)
In-Reply-To: <87389zakvi.wl%kuninori.morimoto.gx@gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============4528017083782474328==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ypm5kX6DjiKlr0N"
Content-Disposition: inline


--1ypm5kX6DjiKlr0N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2014 at 04:07:44PM -0800, Kuninori Morimoto wrote:

> > No, just quote it as you've listed it above rather than with the
> > absolute time.

> Sorry, do you mean list it in source code as comment ?
> or, do you mean like this ?

> amixer "DVC Ramp time" "128db/1step"

Like this second one (just say 128dB/step if it's only one step).

--1ypm5kX6DjiKlr0N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWLxkAAoJECTWi3JdVIfQOycH/RshNcklPwl+NjkRTPI/8Y8o
LbSbVHTjchQchpfzf4gx4PuBws59uvYBT/EDYCnKkyeil2+JRpClUsKLtJgvc4Yd
5i7Y5q4nb6HPDsAB73HCwn2oX+Mm+k6Z8cKcQZTvVBw0WgrqhWCafAIs5hWL67Ax
YTUA71zae18kuXPa2oDJLWOHhjAqhJNFOqOSb5wb4Y8Mj2Tr3K0ltM4YM4D/VVTT
2IC33j1+mB5Un5iqlVRAncVzp1FGGlkCvqPIMOZvk9uf1g7tiY+jonEYxqep07tR
C+VMBe4XCagRF9PLwULSBrfCUjNoVfHbeNr8PwLT5qCSeQwHZEgWOBpzhUUN1ZA=
=MrBK
-----END PGP SIGNATURE-----

--1ypm5kX6DjiKlr0N--

--===============4528017083782474328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4528017083782474328==--
