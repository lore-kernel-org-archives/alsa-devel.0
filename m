From: Tim Blechmann <tim@klingt.org>
Subject: Re: [PATCH v2] alsa: lx6464es - driver for the
 digigram lx6464es interface
Date: Wed, 25 Mar 2009 14:56:46 +0100
Message-ID: <49CA381E.6020205@klingt.org>
References: <s5hvdq05xjb.wl%tiwai@suse.de> <20090324122435.2630842f@thinkpad>
	<s5htz5hluvj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4901604075570425331=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 6762E103852
	for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2009 14:56:58 +0100 (CET)
In-Reply-To: <s5htz5hluvj.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============4901604075570425331==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6D80B64DB4AB8019F2445E2D"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D80B64DB4AB8019F2445E2D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>> prototype of a driver for the digigram lx6464es 64 channel ethersound
>> interface.
>>
>> Signed-off-by: Tim Blechmann <tim@klingt.org>
>=20
> In a quick glance, it looks much better now.
> I'll merge it later after more checks (as I'm on vacation now).
>=20
> Note that the merge to the linux kernel tree will be postponed to
> 2.6.31 since the merge window for 2.6.30 already started.

thanks, no hurry, i will be able to do more tests during the next few
weeks, when i have access to a multichannel setup ...

cheers, tim

--=20
tim@klingt.org
http://tim.klingt.org

The composer makes plans, music laughs.
  Morton Feldman


--------------enig6D80B64DB4AB8019F2445E2D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknKOCMACgkQdL+4qsZfVsuwTgCfXnTAYTScIF9FccmCC+P7oBIH
qYMAn2fscGN09c8vNNBej2U3ZabByzXF
=8WNL
-----END PGP SIGNATURE-----

--------------enig6D80B64DB4AB8019F2445E2D--

--===============4901604075570425331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4901604075570425331==--
