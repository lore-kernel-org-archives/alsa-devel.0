From: Kaushal Shriyan <kshriyan@redhat.com>
Subject: Sound Card Driver
Date: Mon, 20 Dec 2004 11:05:34 +0530
Message-ID: <1103520934.5179.13.camel@oaks.mumbai.redhat.com>
Reply-To: kshriyan@redhat.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-muA1XoJlHvsWCRfiadFP"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-muA1XoJlHvsWCRfiadFP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi All !

I have got INTEL915GM Mother Board with onboard sound chip
C-Media CM9880L with RHEL 3.0 Base kernel Loaded(2.4.21-4.EL).
I would appreciate if you can guide me how to build driver.

I have downloaded alsa-driver-1.0.7,but I am getting the below error

1 out of 8 hunks FAILED -- saving rejects to file pdaudiocf.c.rej
make[3]: *** [pdaudiocf.c] Error 1
make[3]: Leaving directory
`/root/17122004/alsa-driver-1.0.7/pcmcia/pdaudiocf'
make[2]: *** [_sfdep_pdaudiocf] Error 2
make[2]: Leaving directory `/root/17122004/alsa-driver-1.0.7/pcmcia'
make[1]: *** [dep] Error 1
make[1]: Leaving directory `/root/17122004/alsa-driver-1.0.7'
make: *** [include/sndversions.h] Error 2
[root@pcs alsa-driver-1.0.7]#=20

Awaiting your earnest reply.

--=20
Regards,

Kaushal Shriyan
Technical Engineer
Red Hat India Pvt. Ltd.
135, Mittal Towers
13th Floor, B Wing
Nariman Point
Mumbai 400021
India
Tel    : +91-22-22881326/27
Fax    : +91-22-22881318
Cell   : +91-9820367783
E-mail : kshriyan@redhat.com


--=-muA1XoJlHvsWCRfiadFP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQBBxmSmbz6HAjcmEroRAhouAJ92WwswTAdZz+/tiE9LKeeDy2kVfwCgkE6p
oNVrYtXvoDhczcXoqx+jIeQ=
=8/2m
-----END PGP SIGNATURE-----

--=-muA1XoJlHvsWCRfiadFP--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
