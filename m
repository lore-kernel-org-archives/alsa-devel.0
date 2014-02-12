From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: set DIV_EN register on
 rsnd_adg_set_convert_clk_gen2()
Date: Wed, 12 Feb 2014 12:00:08 +0000
Message-ID: <20140212120008.GH28112@sirena.org.uk>
References: <87bnycapmf.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5211716030551403069=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A72A261A49
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 13:20:50 +0100 (CET)
In-Reply-To: <87bnycapmf.wl%kuninori.morimoto.gx@gmail.com>
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


--===============5211716030551403069==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2NLGdgz3UMHa/lqP"
Content-Disposition: inline


--2NLGdgz3UMHa/lqP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2014 at 09:04:12PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> DIV_EN register enable bit is required when you use Gen2 SRC

Applied, thanks.

--2NLGdgz3UMHa/lqP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+2JEAAoJELSic+t+oim9GMAP/AnptI+IajabDFnQRCpiNOxb
0+PYuKmwfoOm+XAj55BGlhkSc6o7iwfwlndidBZ2lmO1HSkZ0Pv5hkwioIH69Pni
hIQWUmAw6nTNCXYcEjfZFQ31sA9i1PTSfF//NGD5nE9DqrpYZJ4u4BtnXHHj1tGx
QnWwDP3oRbBztm80O1SYTn/Pd9ODhCedOYDLGWGPvubiVYLXTI6CrC99BV+knaXg
BPF0bItQd9rPfe9fT4ZwutzAWj45zfgkB8iViZGxWekLbGEWafKq16WCFen/9tp1
u9lqvogVWFHSDrDbkJc/R1dW/v9g2zggjLvroCo4txey0sPc/oq7Tb3EdslgkxFK
tPuNyEmGdCRtZ5T+ibOFU+cUy6mSgeuxOnbw0mrQrPYsmIAwcutx90aEqrZMWzeS
dnh4ccLAcpbAQvae3uPxv2gbytbFkourLYjOGV8+4+lJ9SpmbTTFnKHmoyZ/gD5n
uJcoiVSYlrHOncZ+hJEp6khZk0RNib/spgPcyGSMBZ6NlFf3rP9xE9RRwMr2PEct
qPVlsZ9mlLZPZCA0rIVActQ5hSC1S+HTZB+3lm/0iwQpuNPSFvFwxSLdfjLqxVeY
kErolPwA7qg/SzSwshmEXyoPf0eWB8ybPD5UlMAKT5PQXPWPzY/MtM1yRHpKJVGj
tmMYKyzTMb+RNELyP4dn
=Fm8c
-----END PGP SIGNATURE-----

--2NLGdgz3UMHa/lqP--

--===============5211716030551403069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5211716030551403069==--
