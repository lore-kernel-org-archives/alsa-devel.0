From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 1/2] New Control Plugin - arcam-av
Date: Sat, 3 Jan 2009 15:35:58 -0800
Message-ID: <20090103233558.GR32364@curie-int.orbis-terrarum.net>
References: <200901032056.35982.linux@dadeos.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3574983606001483828=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.isohunt.com (b01.ext.isohunt.com [208.71.112.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 75E001037EC
	for <alsa-devel@alsa-project.org>; Sun,  4 Jan 2009 00:41:21 +0100 (CET)
In-Reply-To: <200901032056.35982.linux@dadeos.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3574983606001483828==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7Us/CiahOveQMyD"
Content-Disposition: inline


--C7Us/CiahOveQMyD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 03, 2009 at 08:56:35PM +0000, Peter Stokes wrote:
> Signed-off-by: Peter Stokes <linux@dadeos.co.uk>
Please exclude the changes to Makefile.in in patches 1 and 2.
Makefile.am is the only ones that are needed since Makefile.in is
generated.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--C7Us/CiahOveQMyD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAklf9l4ACgkQPpIsIjIzwiw9mQCffcVeUWtVIgcf8Sj1GiZTT2Fi
ghMAoKvLNgEBbAaF0M/LZkCMJpckjmaQ
=96Jv
-----END PGP SIGNATURE-----

--C7Us/CiahOveQMyD--

--===============3574983606001483828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3574983606001483828==--
