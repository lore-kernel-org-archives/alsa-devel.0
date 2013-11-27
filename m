From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/18] ASoC:: wm8750: Use IS_ENABLED() macro
Date: Wed, 27 Nov 2013 18:15:50 +0000
Message-ID: <20131127181550.GX14725@sirena.org.uk>
References: <1385044736-14911-1-git-send-email-fabio.estevam@freescale.com>
 <1385044736-14911-10-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6965976421760073429=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 239A3264F23
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 19:15:53 +0100 (CET)
In-Reply-To: <1385044736-14911-10-git-send-email-fabio.estevam@freescale.com>
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


--===============6965976421760073429==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LOXqwSPFWTudtx/K"
Content-Disposition: inline


--LOXqwSPFWTudtx/K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2013 at 12:38:46PM -0200, Fabio Estevam wrote:
> Using the IS_ENABLED() macro can make the code shorter and simpler.

Applied, thanks.

--LOXqwSPFWTudtx/K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSljbTAAoJELSic+t+oim9hNQP+wZKO1w8mtnmu9lmdjjMhjhS
ecZ85Wi2Q8ZxSnooylpRI+Sej0aXtw34ZEuSqRkS60Nye9kqpmWrUEvmghjsl/v0
aZHK2DbnhMcGx5+DAkN6CJ1AIcEy1i1RSNi+ek4hUWCKDILhsTNVdEJDQzFSQGsp
H63eF1OfMzXk+eibO2SULXk5wWELVkJbN/10go+7y/aEv9Bne8efcfzGt3Ka/uE8
57oEmIKSuAXeBcT/YawdCedNxOeOVT+ZCoxyd/nutvtsj/U1Q6qxAOL7Ewxfy3cw
P8EaQxZRwsK/V/evZDx94RluTFlTXU6wdK+fcjVZ5oe2CflPuSnJG5sczG8tCCxN
XEknXXb9dIpqGXVwNGb3McNgFoEaD3rQiZubQgWyx5U+6dGBIrGxCO6uexLIgtUf
srblJk6NJFfNIQ1BIHHaXC7ZVql9V0IkSfC7OlW4AZjS9T2/ifgFgTHfD0L9jyfK
Ufr4fmek88zFBA0KiS/t2pFVLQ3k3Ku70NLJNc3yNdxUSoeFsaYqZtcmQB1eTuUN
AVNM8i+G32hRvZuViEnknek+D27VVGSXFTcqXUrPvNCzkVnsThSvJUX6d0ClyIco
S/kFN0yxaWWaYslKITN9iSSWu+yFJpVAUCD8D7d+NHdmG5fyWguJBiqhwfH2LYVM
8VD2uR5i4K8wwqLhI4va
=kGiP
-----END PGP SIGNATURE-----

--LOXqwSPFWTudtx/K--

--===============6965976421760073429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6965976421760073429==--
