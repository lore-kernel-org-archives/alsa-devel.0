From: Kaushal Shriyan <kshriyan@redhat.com>
Subject: Compliation error
Date: Thu, 16 Dec 2004 19:44:04 +0530
Message-ID: <1103206444.5761.91.camel@oaks.mumbai.redhat.com>
Reply-To: kshriyan@redhat.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5R0fHPGjj/sjRQAxmHjE"
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


--=-5R0fHPGjj/sjRQAxmHjE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

I have installed the latest packages(CVS) from the alsa-project.org and
I am getting the below error when i run make command under alsa-driver

 hda_codec.c:1611: warning: data definition has no type or storage class
<kaushal> make[2]: *** [hda_codec.o] Error 1
<kaushal> make[2]: Leaving directory
`/root/16122004/alsa-driver/pci/azx'
<kaushal> make[1]: *** [_modsubdir_azx] Error 2
<kaushal> make[1]: Leaving directory `/root/16122004/alsa-driver/pci'
<kaushal> make: *** [compile] Error 1
<kaushal> [root@localhost alsa-driver]#=20

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


--=-5R0fHPGjj/sjRQAxmHjE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQBBwZgsbz6HAjcmEroRAoHGAJ4tYZJ8GACshaGBVa++hLqpVJOD9gCfW/gT
/o/OX8rNn9beq0w2QtGcf6o=
=3kxs
-----END PGP SIGNATURE-----

--=-5R0fHPGjj/sjRQAxmHjE--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
