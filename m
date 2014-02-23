From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 063/102] ASoC: 88pm860x: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:46:47 +0900
Message-ID: <20140223024647.GC25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-36-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6126209470724573684=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D578264F03
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:47:35 +0100 (CET)
In-Reply-To: <1392723517-12772-36-git-send-email-tiwai@suse.de>
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


--===============6126209470724573684==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xhQBShgGdvjvx42z"
Content-Disposition: inline


--xhQBShgGdvjvx42z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:19PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--xhQBShgGdvjvx42z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWETAAoJELSic+t+oim9QmQP+gPgz74FPtpe4COWLC50DWEy
IFYusTyHgmIQm5+KFgOWqNaxfgXbaKdgdiPgxNfKNuakFU7nRy2qJ7smR+dSSRyO
nrjbT5XQyOsLmQeY/ZL+v1CLUrfXmHwDzrgbAolAFGG4+wIOx86/tW3WNlNZbYzv
YKw2H95O87f1Ulb2mhQJewXFUAe1m7qLngPkGN9IaHkgCqki/IxIabWkcnW4cPyc
KO4d4EYuuEbS5lvgYTaAR1rSIF48zC3GxD8l7xX8keIxq40jOajpsazjNUeO+eda
KQjDBzZEIDsX/SLQJw+0Pjtf8xiTIzdcLER7BX99vB2B92vl2Hv+tl7tHdJetrUV
SxuVCzYryJSG040EA4CqV8v4OyXUtploo5xyq9sSWfDMt47JhSU6mVV6BjbTlkVr
wbQAMeT/7nYb0cVcyTmHpZXgW1WSPAjtxRkEXJ+3Zki8CCk5pMGwuDcT+y/4veDd
+157zbaSuk5j5BKz95CtXWesgV5hDNv75T2DF+pztWkJp1XAzcg0KI9J026hyWc9
uvI3Uj/EXml/lZXzXHXWGi2ahYnL4hxkfzr7mOnaCTAQsNy034zB5oGShJDuTJTO
uC8eXJSoBGQcoFSQCFyzbvuNZfb8algncbKrxvpUSyNHwLb/YCEm7PSpiTPDBjzm
wSL5rSWinQOJP6SFNUTA
=H1dL
-----END PGP SIGNATURE-----

--xhQBShgGdvjvx42z--

--===============6126209470724573684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6126209470724573684==--
