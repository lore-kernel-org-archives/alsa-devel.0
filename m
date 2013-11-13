From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: blackfin: Fix missing break
Date: Wed, 13 Nov 2013 18:47:51 +0000
Message-ID: <20131113184751.GB878@sirena.org.uk>
References: <1384359300-21219-1-git-send-email-tiwai@suse.de>
 <20131113164715.GX878@sirena.org.uk> <s5h7gccb5i7.wl%tiwai@suse.de>
 <s5h61rwb5e5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3109580728791685123=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A84D82602F3
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 19:48:02 +0100 (CET)
In-Reply-To: <s5h61rwb5e5.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3109580728791685123==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8p/3hdGJBHAENZPK"
Content-Disposition: inline


--8p/3hdGJBHAENZPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2013 at 06:03:46PM +0100, Takashi Iwai wrote:

> BTW, do you have an account on bugzilla.kernel.org?
> If not, please create it.  I have a gift for you.
>   https://bugzilla.kernel.org/show_bug.cgi?id=64741

That looks to be an issue that's very specific to OMAP4 - you need
someone who works on OMAP4 to have a look at it.

--8p/3hdGJBHAENZPK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSg8lUAAoJELSic+t+oim9938P/3oX4zLNT8di4ZD49+MHFVKc
wscj+hB4bW68fdkynFeruwkxwNTH1W3FZGUVB4w01Uu/WtpsRbxH9CNkhvyBrxa/
spZ2XTJQ1vv4ROmYMtKm7tsNdZKv/VsgT4kcEsZ2QkOtHb8+qudqdlIsn2rW/ZcQ
ZuHoOlRLsMspYK+cPNSi+ftEYbdYcWh0SXQe3W6IcbkmfEgF6+XPBB4uWCGtlI3C
jISO2zKq8GEESEYcTzSvjgumpWzPYyEycCNBQPzq7KzAcA/b7sQr6S6kBaHcD+UY
SegyI/2aTfP1Oe5yvC/RFuaV2sSkQ4ZOamtwxGSc1vnwBwl91VH/WfVL1FsisUJ1
5uBhfFwntZ7A81IXzGkZ42/xBJDGFakVKaJQGNHIa6hWdoVusvXzrsP/277cwoFS
t6AFoAP3uWc35et7Zmg8yCnSnFJQKzpSwWFXquAdEE3EC36/IcDeCqR7pn0gdXhM
l9uNHVdM6ifZxv+IJblhdH7mVNaB74ij3mFbHTdiEmqKNyvqdjGwMxOeSAze9h3m
Taeb+N9nEZ0GIO9rozKjWrkvenSgbnoTV4C5dY5hK69qIUUFwXFKkRva4xHRmZfw
6katV6jv9j2SITd7kMgvv3UMdRiSXaiAQihFzvEfPXnpEG9UKnCB3suhsi7X6tpB
4JzgDvfib1OUuZDBZZ4/
=70Nc
-----END PGP SIGNATURE-----

--8p/3hdGJBHAENZPK--

--===============3109580728791685123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3109580728791685123==--
