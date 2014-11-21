From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Fix the issue that the
 private value cannot be accessed
Date: Fri, 21 Nov 2014 18:15:26 +0000
Message-ID: <20141121181526.GA3815@sirena.org.uk>
References: <1416534878-25279-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3552446289478217417=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5003D260694
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 19:16:59 +0100 (CET)
In-Reply-To: <1416534878-25279-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, john.lin@realtek.com, anatol@google.com, bardliao@realtek.com, benzh@google.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============3552446289478217417==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gOOeEvzvHEgoG3wB"
Content-Disposition: inline


--gOOeEvzvHEgoG3wB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 21, 2014 at 09:54:38AM +0800, Oder Chiou wrote:
> Fix the issue that the private value cannot be accessed.

Please provide a better changelog - what is the problem and how does
this change fix it?

--gOOeEvzvHEgoG3wB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUb4E9AAoJECTWi3JdVIfQLmYH/1YZdmumnF/k5YM23CkykpU+
TKfmlaHMVF9mFtbpJNmNyBBtXFyyFXIR5jfMCzl+f78e/3pJzIOpdcrlQUvXVLLN
94kuTeMrBRq1pLAAhHPbVUH2PNKcNaNGKxGaXXos/yOdJS7UUpl7hBhP5y52MzHz
ykf9N8LfbsTEnBr9XV01olSNRkyKCvjE24Zy0vazYHaD2QVbjCvQunldBvABgtTt
WgohuTWXJMvA/wIeL5QRHhj6eEApMvMrzIE3XYboyNGT7K6H1wpKEpIIfvxyH/iC
jrzEf5fAos8Es8jv9jKowFCmJRGjgNKlKERWPQzSbTdfF/lhea8bAC6OnoiSoGg=
=m0Hd
-----END PGP SIGNATURE-----

--gOOeEvzvHEgoG3wB--

--===============3552446289478217417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3552446289478217417==--
