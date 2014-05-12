From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: fsl_spdif: Improve coding style
Date: Mon, 12 May 2014 23:12:10 +0100
Message-ID: <20140512221210.GD12304@sirena.org.uk>
References: <1399365745-21116-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8631289926468844407=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EE882651C9
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 00:12:24 +0200 (CEST)
In-Reply-To: <1399365745-21116-1-git-send-email-Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8631289926468844407==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8BHTaIJNvxgAhOuN"
Content-Disposition: inline


--8BHTaIJNvxgAhOuN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 06, 2014 at 04:42:25PM +0800, Nicolin Chen wrote:
> 1) Apply better indentations
> 2) Drop braces for single statement.
> 3) Use simpler ternary to reduce code.

Applied, thanks.  It's better to do one change per commit.

--8BHTaIJNvxgAhOuN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcUc3AAoJELSic+t+oim9q5EQAJaxl1X19/tewnqm+YtkoZzS
OIETvTwbfE70HQO6Rx5jxgw8nCOAR4F1+xgRmSSgM3DgwtqqCbsrTetSLrbT2S6p
u9gaQ0TodtSQikCQO+YieqInTyZ/srRCGwQ3CHbyPZl0VZalIPTCtiKiGXA78OpA
gWQlE9EBHUxeOt3tCOreEERkC5H8bxjqbflA4+Al/2B9O0AXe95FrRXWMnOHpU/o
jHjHM2Ot/R03LChcmiFUPzGAiuKKLlK+GomNXUTpFv9RCbTAETVdBJFmrGjo7frB
VfD3kbw84/Ht4US1/S4K6KCMyHoaOa0ULzD1bMzOHjmJHwOeNrKhvnsOuosV4CAg
dgj8W2hinHas5JNfFYTmdezrAqlhq+rQT/owWpt/ArC+/pjeSMI8iNMbOjocTS+B
LKDEce5VlOzeJGKeNpKMZyKmcrpr9YY8F0maKitlCHbM9AV/dgu1hdhc7InNIBO2
/uHHXRbJNegLvOikBvNCqP3OgIV5wCsGJ47E3nW46Ko1F+8Sc9yDxfVnYcoCWQ+9
VNlcj6ywyhFOd+UdW+I/Af1xMIQMVdyExWzHjNn7XOgNIrlo4GjmJrm8ZLR85w3F
2uWIqFiMNK2aDN7g5buESDCHncG7dqHt9NGBb3t0eO9c6feg+YEnOh8IXrvNERyB
GFqRaXS+YIml7w2yzaET
=Vd2L
-----END PGP SIGNATURE-----

--8BHTaIJNvxgAhOuN--

--===============8631289926468844407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8631289926468844407==--
