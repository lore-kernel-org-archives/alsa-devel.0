From: IOhannes m zmoelnig <zmoelnig@iem.at>
Subject: Re: RME MADIFX mainline inclusion
Date: Tue, 07 Apr 2015 13:28:07 +0200
Message-ID: <5523BF47.3040901@iem.at>
References: <5522B34B.3090404@drcomp.erfurt.thur.de>
 <s5hd23g9rx4.wl-tiwai@suse.de> <5523BA14.3050904@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7088253927844564747=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.iem.at (inf185.kug.ac.at [193.170.191.185])
 by alsa0.perex.cz (Postfix) with ESMTP id E08C9260545
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 13:28:36 +0200 (CEST)
In-Reply-To: <5523BA14.3050904@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7088253927844564747==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="B0Q9Dg16bikUH5A4S42EPvmJefmCI0rQO"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B0Q9Dg16bikUH5A4S42EPvmJefmCI0rQO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2015-04-07 13:05, Adrian Knoth wrote:
> Let me CC a few I've found - maybe they can test a merged version or at=

> least testify that what they're using atm actually works.
>=20

i can confirm that i'm  successfully using the madifx driver on (at
least) one of our systems here at uni.
however, we are still using an older revision (
ab51234f3e49def959f01bc3b9dedf1a021fcd88 from adrian's github
repository) - mainly because there hasn't been a need to upgrade to a
newer version, as everything used to work :-)
i will try to test the new code in the next few days.


fgasdmr
IOhannes


--B0Q9Dg16bikUH5A4S42EPvmJefmCI0rQO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVI79KAAoJELZQGcR/ejb45IwP/3SfA3hENo7h3gV/5W5xH8hx
A5Xkuh7N1YIcp/UV+LWgciTPOk55nrTyU1rC3X6Mez444WQP3PGX1oPpmpNZQfgF
AHxVvkYwuuZvuk8+nXjgOOnb8xGacB0ufF9LSumbnvD8KkDB0BJ/OoEkRRQiA+6t
NPiu3Zv2dsTprIUwlqMDoMkhdH8k55nwmT3Ny/0iBYF3je+WjvkKzcbz2LJ7leHw
p8E+dWGUfnKzx/CEgfvXdC5+kIbeqg4L5a6eFrKSPtf6b95PvDfsRUI48+KiyuyY
nkBcmDw+YF9JJg6eM9DenNYUiT9arRdW0ieKF7X5G/xkA+p9qREY2CE2ccUWRWae
Z96xwyaoM4k9aqIBr3PQ8K6poCaOsvhLVsftlIpVJb8gQupzqJDn9HV93lXn/5/0
CdGVHEfev+piJsaCbigCI+j3iScNA8LCNcdG42F5YvO3ISreq3hOHf3F3C7K4Vxl
mlozikBkA1eeOjZdOmxpbnFROoXP3i5twy4wnqnKpjtRzkMcn5AAeZOqvYpmvbg2
2HrghnRqv3Ors9tUwS9a4uyGWG42wxZSUx15jF/V2ZeQyVAPP0FCcol+awW0Phhj
RPIt9lQVyjjQ1SdVo0W1zWbdTrpCm233DsuL6Q8tXSTud/pZ2XSjRIg8HS5CUKgJ
HP6ii8x6NQ9blD4ZiuHu
=/mc+
-----END PGP SIGNATURE-----

--B0Q9Dg16bikUH5A4S42EPvmJefmCI0rQO--

--===============7088253927844564747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7088253927844564747==--
