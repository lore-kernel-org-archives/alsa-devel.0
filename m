From: Johannes Berg <johannes@sipsolutions.net>
Subject: alsa and locking
Date: Fri, 19 May 2006 18:11:02 +0200
Message-ID: <1148055062.6228.19.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-X6oDHTc70sizP2TnjwSx"
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


--=-X6oDHTc70sizP2TnjwSx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I was looking into locking a bit but can't figure out what alsa already
locks and where I need my own locks. Any document detailing what must be
done and what is already locked?

johannes

--=-X6oDHTc70sizP2TnjwSx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARG3uFKVg1VMiehFYAQL8RA/+IXfov5vR0lYo8ddgRHqhYnB/jcvFiqsF
tpIw4aHdgtI9WnNkMNsntnfx1zTNuyVK3d3GU7b/jlKZN/05pDX6UtzP7sPvY/Zq
AWPAXsf17s75WMby0pKp96eiEv7L325TqwSNva3sVXTUilxxcw3+JiS6WvSaFhgT
tHdwZ3Ckpjwer5zDaNi4ejzrjMlsexq3kE7CIXDjc35nRx/V8lRl5vSpkmL7MgMK
QRSWZ4wBFaVVQbAGs079yD6hf+e/R9zupOcmfr5Y8U9oxmx8gFbBGS9xoW94RRPR
RKF3/cJMimI4FV+fXxYuQ3jjUKlygwU9uallPxKjPPZAYvSCSeroD05zHY+xxhmz
MtQ8+IPndpf+mJALAtO3/VrnfmHrCGH6g4HVsVUvjovlYIxWqvhh0OLHKt59TpaF
epF4zkbpL0uFyWqSTbujUx4Y04+W+fWyG0jb5hC+HkujBRavc+ZRN0+9UnoCZtbG
tAldGubZJ7ATUlEXXJ/PTSYI5tWP2wp0kKu2noou7D3n3Wt3VoGTDJWSH0G+W9Bt
pwdJF9OraNwmPov0WxcSEEnBUmbNdlp73zyjEUBpshuMGrto52lch4p6smnZx+8D
En9V+Uj00/f1mDcyQ4gfVZj02CCuH0m9fAoVnrp6hsztIZRupz3ZVW+MxPnkn8jp
VQwII8dHLh0=
=lcCe
-----END PGP SIGNATURE-----

--=-X6oDHTc70sizP2TnjwSx--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
