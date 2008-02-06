From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: Re: OSS4 X-Fi driver port to ALSA
Date: Wed, 06 Feb 2008 01:58:52 -0600
Message-ID: <1202284732.3719.182.camel@petrie.sacredspiral.co.uk.sacredspiral.co.uk>
References: <1202160350.3719.76.camel@petrie.sacredspiral.co.uk.sacredspiral.co.uk>
	<s5h8x1ytuku.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3191371154015240651=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (unknown [64.71.161.129])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B5E524499
	for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2008 08:57:29 +0100 (CET)
In-Reply-To: <s5h8x1ytuku.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3191371154015240651==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uDDgZ796jnC9Sz0Py9Wc"


--=-uDDgZ796jnC9Sz0Py9Wc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-02-06 at 08:25 +0100, Takashi Iwai wrote:
> At Mon, 04 Feb 2008 15:25:50 -0600,
> William Pitcock wrote:
> >=20
> > Hi,
> >=20
> > On Feburary 1, 4Front released their XFi driver to the public. Is anyon=
e
> > looking into porting this? If not, I will give it a try soon enough.
> >=20
> > It seems to not require any firmware at all too.
>=20
> Interesting.  But it's not released under GPL or so, I guess?

Hi Takashi!

It's released in the OSS4 GPL tarball. The hwaccess.* files don't have a
header, but I think I can probably get them cleaned up.

William

--=-uDDgZ796jnC9Sz0Py9Wc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHqWi8oB+26npOQg4RAs9rAKClpwg0Wxvt2qZ/txyNkr0H9gVtiACfYt44
GWSadDw1/t4XhBeagDJt16k=
=jDn5
-----END PGP SIGNATURE-----

--=-uDDgZ796jnC9Sz0Py9Wc--


--===============3191371154015240651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3191371154015240651==--
