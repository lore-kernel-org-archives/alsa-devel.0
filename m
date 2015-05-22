From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/7] ALSA: hda - add new HDA registers
Date: Fri, 22 May 2015 13:58:17 +0100
Message-ID: <20150522125817.GY21391@sirena.org.uk>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
 <1431341645-2457-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8928966735165423802=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 61FBE265B3F
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 15:07:44 +0200 (CEST)
In-Reply-To: <1431341645-2457-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8928966735165423802==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dwN3S3mscniL3FCL"
Content-Disposition: inline


--dwN3S3mscniL3FCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2015 at 04:24:00PM +0530, Vinod Koul wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
>=20
> This patch adds new registers as per HD audio Spec like capability regist=
ers
> for processing pipe, software position based FIFO, Multiple Links and Glo=
bal
> Time Synchronization.

This appears to have some dependency on Takashi's tree - Takashi, is
there a tag I can pull?

--dwN3S3mscniL3FCL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXyfoAAoJECTWi3JdVIfQQXAH+QEgL+3PpqFwadQnszEUBViW
q8OE0ZThWp/b+JO81aj3fJaGDIL8EGhgUs/Z+dwfVhBxmFoBcbjlZFQDSbx8UaKl
sCvkXjoYUniyZZVtY109zFymnUbOFpJQL7jT0nFA1oTcDNWtvPFUi5McblsQwV7g
J+8qs6q5pVE4oMe4C5maMDcuHLWqsKaDhbenpC2nAgt52tIbpjNK5DISUGcUnY1G
exvw4vqDA5Ng5VRn12ROf1tnwmR13wVA5URM7B3yUYgJ6A/xrxcXWh/z629dnQN/
mQ1JsTeJYYPzVCjeouzXqhtG4crwiludZCquQmmqO0kDMssOhODJl9jLvcatFB8=
=4pDt
-----END PGP SIGNATURE-----

--dwN3S3mscniL3FCL--

--===============8928966735165423802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8928966735165423802==--
