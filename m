From: Tony Vroon <tony@linx.net>
Subject: Re: snd-hda-intel and MSI
Date: Wed, 23 Sep 2009 17:00:54 +0100
Message-ID: <1253721654.3434.59.camel@localhost>
References: <20090923143306.GC4488@aragorn.home.lxtec.de>
	<s5hpr9hzmx0.wl%tiwai@suse.de> <1253721163.3434.57.camel@localhost>
	<s5hk4zpzm8i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6537081357021776475=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 9137F10389F
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 18:02:04 +0200 (CEST)
In-Reply-To: <s5hk4zpzm8i.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============6537081357021776475==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-dan3f+dnQZh3X5h5HQ57"


--=-dan3f+dnQZh3X5h5HQ57
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-09-23 at 17:58 +0200, Takashi Iwai wrote:
> But, this change is unlikely for 2.6.32.

I would be in favour of a 2.6.33 experiment though.
(Especially to invert behaviour, and make "MSI *will* enable but break"
an exception controlled through PCI IDs)

> Takashi

Regards,
Tony V.

--=-dan3f+dnQZh3X5h5HQ57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAkq6RjYACgkQp5vW4rUFj5r3xQCfcniWUmp/vSN3aMBgBucOyGhe
4yUAoI9V2i4RZ4vWQI8fCt4edvBEve0P
=nSAd
-----END PGP SIGNATURE-----

--=-dan3f+dnQZh3X5h5HQ57--


--===============6537081357021776475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6537081357021776475==--
