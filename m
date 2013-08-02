From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Fix empty list check in
	dapm_new_mux()
Date: Fri, 2 Aug 2013 17:11:40 +0100
Message-ID: <20130802161140.GO9858@sirena.org.uk>
References: <1375374638-28305-1-git-send-email-lars@metafoo.de>
 <20130801184427.GX9858@sirena.org.uk>
 <51FBD3B6.4050403@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5417948111747060935=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 44A0B261793
 for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2013 18:11:49 +0200 (CEST)
In-Reply-To: <51FBD3B6.4050403@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Olof Johansson <olof@lixom.net>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5417948111747060935==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6ewWlCbOyU0sgxOR"
Content-Disposition: inline


--6ewWlCbOyU0sgxOR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 02, 2013 at 09:43:50AM -0600, Stephen Warren wrote:

> I don't see this in the ASoC git tree, in either for-next, fix/dapm,
> or topic/dapm.

I see it...  it missed -next due to being pushed out late.

--6ewWlCbOyU0sgxOR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+9o5AAoJELSic+t+oim9ixgQAIO2MM4oy4y5j9mcfxq0udwf
z9NeB4fqC4v6rw4gYwCc82JUjMDoNa3DA25c4dsFvGfdlKhSrFVWsiWsKYDVbAm7
g6ywUh7tU1I4uGCbLPWFT4fS+S6wUXjJlpKuvrDMLjeK8qe2jDciH0oY4ozJRut2
rou+p2YWCESIuKvxS7jUi9xa38dmLWM0lLYq8x3pmCXZ8MNQFAjRsf+SHEhS+ScL
kzOUVbxLkntsTu/uAZPPBY7FBfyJmio9TYHeyu4KKwmsEkdN4nWq+2fhALKx+gzh
7z63RN2N1bmU8KSXxqu+ORIOARimso/ttGQIC7vuU9IuLA8n+ihC7Uh10JsPZPWa
YyhP3GDHSuWVOF+Vs3YhHfsK3eDxTxXhsuHXyvAcguze15f55n6uvdW6wgTuwRiD
xxcGZOp4g+i4NSscN2qF1uu9Xcpi4WIxMnvTc5cOTVkETClrOR/dYYXQNeW0p5nX
CaPGv8WYQlwer2AL+MSyljSuJdhAD/aguP5sQsCyOmPvZ+tEj06N+MUmSE65yvNv
VZKsrvLM7pX/iqE+uRtNCIX9bvLKM2l0fybEOUOhS1I7+RQVDxiB5VRnGm8+pS5y
SRYiSYR2zw8Y4OSD3w+U9NRbzKPBpW1VD09WNyuRYQnri6/POhcaD4+ZFluM7Zds
5SQLwCoM9mlABbtoXPf9
=l5HM
-----END PGP SIGNATURE-----

--6ewWlCbOyU0sgxOR--

--===============5417948111747060935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5417948111747060935==--
