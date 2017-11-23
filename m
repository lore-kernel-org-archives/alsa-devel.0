From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [GIT PULL]: Geminilake audio firmware update
Date: Thu, 23 Nov 2017 01:49:08 +0000
Message-ID: <1511401748.14687.14.camel@decadent.org.uk>
References: <20171107050032.GS3187@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7991207739286659386=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126]) by alsa0.perex.cz (Postfix) with ESMTP id B0099266B67
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 02:49:25 +0100 (CET)
In-Reply-To: <20171107050032.GS3187@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, linux-firmware@kernel.org
Cc: Patches Audio <patches.audio@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7991207739286659386==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-UwxbH97ZcoYrZtujim4B"


--=-UwxbH97ZcoYrZtujim4B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-11-07 at 10:30 +0530, Vinod Koul wrote:
> Hi,
>=20
> Please PULL to receive update for GLK audio firmware.
>=20
> The following changes since commit bf04291309d3169c0ad3b8db52564235bbd08e=
30:
>=20
>   WHENCE: Add new qed firmware (2017-10-09 18:03:26 +0100)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git glk
>=20
> for you to fetch changes up to b964279f2d9955a6ce00d3a672b273ae4d7a362f:
>=20
>   linux-firmware: intel: Update Geminilake audio firmware (2017-11-07 10:=
25:50 +0530)
>=20
> ----------------------------------------------------------------
> Pradeep Tewani (1):
>       linux-firmware: intel: Update Geminilake audio firmware
>=20
>  WHENCE                     |   4 +++-
>  intel/dsp_fw_glk.bin       |   2 +-
>  intel/dsp_fw_glk_v2880.bin | Bin 0 -> 505608 bytes
>  3 files changed, 4 insertions(+), 2 deletions(-)
>  create mode 100644 intel/dsp_fw_glk_v2880.bin

Pulled, thanks.

Ben.

--=20
Ben Hutchings
When in doubt, use brute force. - Ken Thompson


--=-UwxbH97ZcoYrZtujim4B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAloWKRQACgkQ57/I7JWG
EQln1hAAzHluetgHhGT+9hYKMG8yZav8rLmagtxzN1apCgJepT/JMibZtAm8GZg4
CJ5HmUsIC80rSu9dNfvbtHSAWRhF7BUvTody5S4NGoVDkdCIFcK0d7YSkgq9hqua
jsBnSDcz91BWKoZQZvUbrjU2bBsgfbrwy94xhqwEnLLPYLxnAREKeUEddFhJdndU
SGHXmVpHlaNvCib6zO3vmSuoebw18+yEHWO1A/SjDve0xqES3HPHPjwLN0ZwIddE
54pgxACDWNRmARVNwm6Tbu9ZPSZCs4prSo9XMeYxGAo2QVudnRSQeuGmuiWC0Ipm
FQtrsbNoqrZlvMO1Hs2Ju/hRq5mxMSST9eFe6bKW/c+L7jPnRvgpdqAZo6T8dj+8
TO3OSs36cVd397xguBjWQNqVZ7+/zpE69pKfvDgvT/ZTgK/6QOCxXZsNIZ2P2DcU
/BrA77AY2+g5ftkBud1LvfGir0T6yO7dUz6jWRF4DNed2XiIgEO27GY56Ej70FKh
uKoeyIeJSHTQCpYe6cCGo0WIeR+cEPnLJyzkNyIL2YKqRoaIFt1zZ6z9N6XhvRY8
MKjro8BS+pKVxdAFZuexpsorwCfLi5K1qPYGJXXg+VhjXh4rhmRHODzmjq/Uqeex
4RshFgOXe4PoIK/ysiePvztWxndbNaPZtNtuqCUwb1155E8GbBM=
=MSjd
-----END PGP SIGNATURE-----

--=-UwxbH97ZcoYrZtujim4B--

--===============7991207739286659386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7991207739286659386==--
