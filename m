From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/6] ASoC: tas5086: Include linux/of.h
	header
Date: Wed, 16 Oct 2013 19:01:48 +0100
Message-ID: <20131016180148.GS2443@sirena.org.uk>
References: <1381492441-31195-1-git-send-email-sachin.kamat@linaro.org>
 <1381492441-31195-4-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5818694056643405442=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BE50526526F
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 20:01:50 +0200 (CEST)
In-Reply-To: <1381492441-31195-4-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5818694056643405442==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KeIsG8VqVRB5JorP"
Content-Disposition: inline


--KeIsG8VqVRB5JorP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 11, 2013 at 05:23:59PM +0530, Sachin Kamat wrote:
> 'of_match_ptr' is defined in linux/of.h. Include it explicitly.

Applied, thanks.

--KeIsG8VqVRB5JorP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXtSJAAoJELSic+t+oim9k38QAJo2OoW6oKHaFKKP/V4B3Isc
L1g1pe4r6NET/ZYSvM/lCWEuso7X0oIHvtVeNnQBgebUQhuz00ydPSZ1xqAyrPcA
y+fgrw6Cpj+pohPJJsYDEB9bozwjhy4benSxaMASXc87FF1xq9DQ4uBaVi1x/pW8
RXKXGJPwlT+YcGW0gev8xq0ZZ+e0CGliPOZ6evyKXPlbRzwQCdKDIxigwDht5Zuw
IaXFdV9vl0blLHcMuNLtybDcCwUDLmpMxhDLlcncFX8v5qnPnv6JayPkcKkpoWqI
LOmsh6SDy+r9HqJ0bX1R1P38vz38oSq6ecNt/M8HcZ8TA5hLt9Sh++I1+8+iRvZc
uTai9yXxh1vNaPcV0BoPFAH3cpnZI0lbPseyp4BrMZ/Vnubb2KTuhjBMiFgjJHoi
eUgT59/mNEtPCkxNW6iOYJEfc191Xcg2Ls+YScvktyIZrap0u6c65Ska5I24aEuH
DlMm5XWJtWhxD8O86eTRZPAkoKJyTVlW4MKW/xthLXuYCQqnAO0eJ5d+UEmOTjSM
kRnmyMo2tkAtIbcFv2+VmqsjIp3tC2hIKnoUtDa1hRd8ppyOX4Z+EyfNF9HnIvtJ
Fn0oGL0lZlmVGiiu6E3VD3pSzn2JEMNdq+ADd03qleFQAMhbKLDpq342tXN/DW2z
bGQhX8YUglDeFIJtnNBe
=YB63
-----END PGP SIGNATURE-----

--KeIsG8VqVRB5JorP--

--===============5818694056643405442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5818694056643405442==--
