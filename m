From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/18] ASoC: cs4271: Use IS_ENABLED() macro
Date: Wed, 27 Nov 2013 18:12:33 +0000
Message-ID: <20131127181233.GS14725@sirena.org.uk>
References: <1385044736-14911-1-git-send-email-fabio.estevam@freescale.com>
 <1385044736-14911-2-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3687111238421910586=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CC99B265165
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 19:12:35 +0100 (CET)
In-Reply-To: <1385044736-14911-2-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3687111238421910586==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oc4Z9ongRuk6y2kD"
Content-Disposition: inline


--oc4Z9ongRuk6y2kD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2013 at 12:38:38PM -0200, Fabio Estevam wrote:
> Using the IS_ENABLED() macro can make the code shorter and simpler.

Applied, thanks.

--oc4Z9ongRuk6y2kD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSljYOAAoJELSic+t+oim9hfwP/24q4AaEyLEMC1vOiQxPWWAc
42mQePYt/46L8RsJL/9HscKX+djlCkckHECyUhmExt6LiLoUf0AOvHJMdtSLjuqe
bcpK27RHieq6QlyBpdH1WIzKTOH3q7qM32M7y5n38E74u7GfNR55JaGt3wcmrarQ
P98oaECiWlUFHO5+aH7XtNmv+OH2q64P53+ImTff5a//D+F1ABelT9SFNziWcTwE
312efa7Bae0aKwt4O70UOLKtzuk9CPcVdr20oWUa7MkHry8d4+F8vIw2qXo3Y7Us
5zWscio/UwY37WemfsFNKhy7o7tSWcLNfHG+DOIn1OSMaS35T+Ye662X+sEiobDV
C98h47uI4yG05YlHC+VLEcMt39q0r9rF6MoyT8CcmkFHDRLjo7dW92uqZWJT2iYA
Rh7C+UL/3NU75qAO8Ee1rsWSYXpw5w9BCEnuSJihQXfesy020KYdPuOR+FskUMJM
OPFpaRoGeH5gU5qbvp9AMQ+L18+eZMDefDlwAzXxdo6yYxACbbiaVy55zZkG4izi
Tpl9cBzOUtlBuOAUevDa1ov7SzYDiVGgSbGNZlkeY1nhPTUIH0xYesvWx6Z94aCJ
umAzuXhQhytIbOEEe0Sd3pSOas5o78BiH5bTJ5YZUQGd3olnyGru0nqYgH+0+hBV
djcXpqZv0FavZcmyzGgm
=Kp/3
-----END PGP SIGNATURE-----

--oc4Z9ongRuk6y2kD--

--===============3687111238421910586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3687111238421910586==--
