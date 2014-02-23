From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 072/102] ASoC: wm8955: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 12:04:16 +0900
Message-ID: <20140223030416.GM25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-45-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2724674600218008667=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DA340265281
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 04:04:45 +0100 (CET)
In-Reply-To: <1392723517-12772-45-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2724674600218008667==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3ALZ8E19BIoSIFJn"
Content-Disposition: inline


--3ALZ8E19BIoSIFJn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:28PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--3ALZ8E19BIoSIFJn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWUtAAoJELSic+t+oim9A2gP/0dAqLaKHvB5A6dcJgzoZelC
a3EeY/vQnY8+XBMUUJSWUmHV4KxoZNGqvUC3bzlw9O7uWHJqkHTNjEl5by1jcWAb
kpnZ75L30+g6Sne0+z2VMJkYsohbD9xNjOJnFhe5QmZnWCeHQsIrVEUrGbnY+PRH
nfFi6tJyGPSsx8I9XQn90q9WPpmJxxJ7JwN9vpLeAEmUnWzRZcEgVVxg8rEdP0lj
BV4zV6F0JkW81+9dEZDahgCzFMfpEPsr3sLbSsTTUe1kf/LOGWJtS2kFBaZQpt+x
WAkY/bHWrbxy2b5SIGIJ17juLgdgP10257OMWUi2GaPiWk/SO9evv3sanhC+6dk9
JazvvCnl/J3j1YCj1ITvKo72P55om4y99YlzTGZZiZczckm67iIq1LT9KySNtJzf
NGszSpxKJZDrCB3ihPbMXcIIYDhq+9waJaCYD/MKtpIG1wDsbT5qiEXEdEptR2uz
qPos469gmYz0Adlut/UpG/Ox9bMG42SLtjQDw69DR+w4i8VQ1Inl8fj4xuVcqhgf
DxM/cNfUSVwpRN+EcY5H3rpGFBjcngFfqNjNex+ITVs4/hWftt2LIMhOaIa5MLN1
0nayodZWw4oZ69oLdULsZC0dOmwwQC1sCDeFV2KRqQ0/ben+xBvL6Ok7Pa73w+Sm
6iNytP16XILyO+OZ+aPI
=0fGI
-----END PGP SIGNATURE-----

--3ALZ8E19BIoSIFJn--

--===============2724674600218008667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2724674600218008667==--
