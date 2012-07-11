From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch] ASoC: STA529: fix an error message
Date: Wed, 11 Jul 2012 10:38:26 +0100
Message-ID: <20120711093826.GC3938@opensource.wolfsonmicro.com>
References: <20120711064123.GI11812@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9045968045040526594=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D01224440
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2012 11:38:28 +0200 (CEST)
In-Reply-To: <20120711064123.GI11812@elgon.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============9045968045040526594==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2012 at 09:41:23AM +0300, Dan Carpenter wrote:
> GCC complains that "ret" is uninitialized here.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks.

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP/UmDAAoJEBus8iNuMP3dPekP/32LKNeoKswRhWT7t0BLrxZ3
t3QBQ6DMFztxSK/NVbMiQ+FYpQ5Ilwlb4sNxUpQV35BF2cm1wPn79dJhxjPATQe9
zpfeF5CQd5Ap9bvx2BqNnDTq6tRIp8kt91JDGSbPp7TT707D+cu54w1eR5Mio3Ql
1+voZHhA25YDKsgvQZFPT2sp4R21kaMwQ6byK8YHvivvkrM0AvgKDamBGJJfhT0Z
RA38a9PUPW41y6J9125QBvSd5HKxqWb5DwZHKTUqTBi/x1g/XKWWNZ1TuraNR739
hTGSyZht1uRzh1lB+45wzl22kk6QrW40ZNK7hg2QuAcfdoLpOFsPLBW2eD7yNQCQ
Y1v/KxRCHUgf0LiQD9+gkZC+UzsF7FUBj/mamJGKwqcFWX2zOKMiQBxV7HH2z2wH
cW0eK0ZepZkOVIo3/ac9RnfhTq/VgOGR14e2kshidfsgH02GJvzJg2/wpG2zRVWL
aSlK9gmcCP2vefbxgGETXg0vKrOetDs4lpxnCzi8TWtnnnCva6x2jd7EayvHIGRK
KxToQTyvKCvxLzH36Pz5ZppG7YOBwvnhoRbI9RJf+Fc5QoHpDWCsHytpKCeVePQ7
nOaAlc6VUBsNDfA7sGgvEtjyrJ4p74J6edOOdbfk4bQyIU6X54UDQ29CI1vpiY47
aB6qsDHOOrDSmmxJhHjg
=QC0r
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--

--===============9045968045040526594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9045968045040526594==--
