From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: tegra: complete Tegra->Tegra20
	renaming
Date: Fri, 6 Apr 2012 16:46:24 +0100
Message-ID: <20120406154624.GF19424@opensource.wolfsonmicro.com>
References: <1333662894-22672-1-git-send-email-swarren@wwwdotorg.org>
	<1333662894-22672-2-git-send-email-swarren@wwwdotorg.org>
	<20120406132324.GD19424@opensource.wolfsonmicro.com>
	<4F7F0F50.8070205@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0339289193527522029=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 67E5C244A7
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Apr 2012 17:46:27 +0200 (CEST)
In-Reply-To: <4F7F0F50.8070205@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0339289193527522029==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DEueqSqTbz/jWVG1"
Content-Disposition: inline


--DEueqSqTbz/jWVG1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 06, 2012 at 09:44:16AM -0600, Stephen Warren wrote:

> I'm not sure when "things have merged back up" will be; do you intend to
> merge your for-3.4 branch into for-3.5 at any particular time, or
> perhaps rebase your for-3.5 onto v3.4-rc2 when its out?

I'll merge up the commit from Linus' tree.

> Alternatively, I can regenerate that patch against your for-3.5, but
> then you'll get a merge conflict when merging in your for-3.4, since the
> code it affects will have experienced a rename. Should be trivial to
> resolve though.

If it's trivial to resolve that won't be a problem.

--DEueqSqTbz/jWVG1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPfw+6AAoJEBus8iNuMP3dirIP/0iERd+qRX0V+8cHvRNrjmQS
iRDESDxBXt5JzU3pFaIFukGKNZzB0gDm6Zme6pAjCDJpyIliqoHTAsyqVZ4cPPO4
EJFBx/9ptSxbiUY6sEY8/ITrYBGOTKG1OayuGAbW/mkcLETZ3NLkptgNQDXmbV8I
+S/eegNTdpg/OFKy3Xa4/gXdJVlR5pPeReMU8lVZcpEsPlrTvUa8wSOlJz0HD+L5
tldDySysV9vHcay8Of+LY92qZ7fAHP3mWfK+rit8mxVoq0qEtq8XHhOvNNdwJRcA
S+k73zC/5bgAUxwVDxzwTKdKhwaJXlBrvxZC/loe0zu6xXVVRsybd735Pm9UELsa
5Dst/K4wXUzPBpde5yJaeCPv6dK1RQSABp7qY94lGN63DMXOS6qFJ99QfWLAoNv3
GKvhZH9sRugAPYFLJZ972hcIalpfR6RvOtTg3u+XrSfKwLwv8wbkRy+skeuKA87g
hNNpIvSD1oPGe80F93O2mS2eMd9tlhrRFVa7FNqsmZqRiY+em8aTTcJ5l8CKaoJq
X1GTSEECskcHSVyN0xwfxVuWkhYdLLBXzZCQ1AyILZmPe02S6agDX4Oc6lJoIa7z
wYUTiIP2ij+9TSbJ2YZVWNG4Q7amnZrkqlKPfbHN6100ktFTbqc4fRmwfDxfm9Vj
DfWolla8vuz0FuSsDSkp
=/sBN
-----END PGP SIGNATURE-----

--DEueqSqTbz/jWVG1--

--===============0339289193527522029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0339289193527522029==--
