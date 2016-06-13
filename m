From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: rt298: Add jack suspend and resume
	functions.
Date: Mon, 13 Jun 2016 22:34:40 +0530
Message-ID: <20160613170439.GK16910@localhost>
References: <1465820919-6105-1-git-send-email-bardliao@realtek.com>
 <20160613140923.GH2282@sirena.org.uk>
 <20160613165537.GH16910@localhost>
 <20160613165046.GL2282@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6784419655462377637=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 210A1266A72
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 18:58:10 +0200 (CEST)
In-Reply-To: <20160613165046.GL2282@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, senthilnathanx.veppur@intel.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6784419655462377637==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ogUXNSQj4OI1q3LQ"
Content-Disposition: inline


--ogUXNSQj4OI1q3LQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2016 at 05:50:46PM +0100, Mark Brown wrote:
> On Mon, Jun 13, 2016 at 10:25:37PM +0530, Vinod Koul wrote:
>=20
> > This was based on existing pattern in rt5672.
>=20
> Oh dear, that's broken and should be fixed.

Sure, I will try to fix that up :)

Thanks
--=20
~Vinod

--ogUXNSQj4OI1q3LQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXXuenAAoJEHwUBw8lI4NHwBMP/R3TVUYljKtH2ekMh7w+qTL2
apSiyavBWYp9QgURKhPSNm7aB2p5fYjB+iiodG+5LSqrwtXAwXtf3Ih0wRgbWAPy
bdJnutLfjWMnRYi+c7W4Uej+UWxfqE7IAxuGFDWB0GZF3g8aRVRXSrTVZT8IbXpE
VhceDxCbH6s0UAiAcfiQDzqbyV6IYuKKWeQxZs0JhLtsuaIvXvCPc1XkJphe70gE
7hg9b1qzM2olnJTHiNyyNZH12etGr6HPueR+CkFfT/pi+8onYgQDjaJyU1IDWOT3
w5lRrxulgkKkZY0jSqJ+KldbZJ/zpJHeQO2n1kDCfHYrkn9hRCxgWjJfbsPn6JkW
zIQTNCNK63vaBos2Yy+gX6XFO+q2/q7XAXm8jXGKVPlhTj8uN/VlX3n7D++KfTgQ
loEFGXY5slRRbKXlGtK8t/Nee/jdDrQGpxURMfL8znlQ1cmIUXMfaz8ksZgYBIRz
peLZpvEkxowIo0PLRNaL8pGTU0pdIm01v9Nhl07Esm9cH0IE0SjNwtice20Twinf
czzGjGpofGzKfIQywKH+5Q8URP+cJR+XspTlyWhYg3mJ/x87QfFZZN91XI5Bt1qq
5iNwDMZ2EqUjLzOy5zmsrCzP2Tp8NGXy0LQbfyGkQBdFHa3y2NpyoxzlqYxpHTCi
zT6+8OK5IwEC91yAUNI4
=r7+0
-----END PGP SIGNATURE-----

--ogUXNSQj4OI1q3LQ--

--===============6784419655462377637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6784419655462377637==--
