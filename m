From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] ASoC: atmel: Include linux/of.h header
Date: Wed, 16 Oct 2013 19:03:34 +0100
Message-ID: <20131016180334.GU2443@sirena.org.uk>
References: <1381492441-31195-1-git-send-email-sachin.kamat@linaro.org>
 <1381492441-31195-6-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3526099662217346531=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AB2AE2651FD
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 20:03:37 +0200 (CEST)
In-Reply-To: <1381492441-31195-6-git-send-email-sachin.kamat@linaro.org>
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


--===============3526099662217346531==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZixuE2NkFB3de4Gg"
Content-Disposition: inline


--ZixuE2NkFB3de4Gg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 11, 2013 at 05:24:01PM +0530, Sachin Kamat wrote:
> 'of_match_ptr' is defined in linux/of.h. Include it explicitly.

Applied, thanks.

--ZixuE2NkFB3de4Gg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXtTzAAoJELSic+t+oim9VIgQAIt0SBv7WlOrEVHVhugkKV7g
TInt1iDk522aHb4f3UBmIwWnPwJT8exHFdgC41+Ll5e7Qps/+IL9OaMLEDLo33iU
xkArRaY64Ebu8Lkmn9gA158Ne+0PRWkYs2YoWfm6f+0LxzBjkCCamf5XLZNtsB3o
srUBgc0ZhxxTCVdLd7JxMtYY+oyRBqBzeg0g1p4jsgKb11fhUpS0mU/B5ZZ/fMpJ
yD3Z/kEH0r/0J7VFvlRbtxLn8BQjc/KQb2QTBe7q1liOYFZd9sAX+YD8KbGq+iqS
pXmXuOIhmThhYXbR+1TgRto8QW3JmtuWGyASdkb2M8FMWV4JvgsOMFNsNayMOoh+
LbjBHhAAB/dJ8UZSJ1Gi52UHRpKycbTZpMK1lwt/gMWEL7fGuuMhxg+Zm41i352B
PNTPX0z0uAxM3IwwzJkRl5ky0b/obeABwFn+ShU/FbrC7WidwTZjjW9kI6SkFXFG
kpTStJmtQZxPTAxJJtS50l0fiwH1zIwjJtg3ZgCkRi6eM5mdP1nonI7mqUxiCgdr
zrW8qEbLJRSU62hSRLmDsy8SARd1dkof6sYMyrQhT7xPUMYs1/Y2InIRD5zBakXW
Am9EE2NGUiYXJ4bsPfshx0MuSra7LrhppIMpi5Ynz3ePGZwjDDVi4mly9bD3VRry
KtsZ/KFuhZxXRYhDK4RY
=VIPy
-----END PGP SIGNATURE-----

--ZixuE2NkFB3de4Gg--

--===============3526099662217346531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3526099662217346531==--
