From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RESEND] ASoC: omap-mcpdm: Convert to use devm_*
Date: Tue, 24 Jul 2012 20:16:17 +0100
Message-ID: <20120724191617.GA3099@opensource.wolfsonmicro.com>
References: <1343036391-1326-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3316355101158801818=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 00B1F26036F
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 21:16:17 +0200 (CEST)
In-Reply-To: <1343036391-1326-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3316355101158801818==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23, 2012 at 12:39:51PM +0300, Peter Ujfalusi wrote:
> Switch to use devm_* te make the probe/remove code more cleaner.

Applied, thanks.

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQDvR2AAoJEBus8iNuMP3dAcAP/Aue0opbavqFAYlALaH0/WzN
HoyMquuTQtGkl6qQLipgH5pWyGH6SvgGMXiIWLkPy6DkuxFmzrDxjKs/xThfVIMu
Wlcai8IDgB0PRPGTWJwjy0sS3767VYlKq7U2mEPMkNrhZI1q1XM8YiqaXAAEM+5r
7rovB+4PTFXiz5MSz8Hgb/KUnhKOFAGeZjiZ9Yn16IEsfLZRfCbkwcQ17ANrkGu6
dR5w/uyDG9drt1oLwqfOHckmAP0jQbjAYAYphVe9JSaEIb5ZUqMY4eDgnfzdBu7W
4Z3LGtv8eia3fwYSSIiRtSDIoX+Iil6rgt0P9ogxCy7DsK7vfYUctS2MdeAIHP5A
Ie2E50Npk6yP7CwZdh1iDYEC9ueUKkbs0sDYQLwgn6/wXiXGuvddfb9c201ZB/UW
UtQs3COzdKPBK8RoXFvZE4ueFQzkmQbreKQcSuYTDmFI4tjiZ3nUuSBXx+mk73Xv
JMvtRObrlMuOrZ/pzd0VYNTeynDR/CHCh1J7sdoJ2yVIi/V/OmBLdVDwBgc2+GqQ
Hdrfv23o153XCBLABFjA/ARb6GDSzPQo5HFfnP2rJtZScHN5TnFuVANCIYrUG9Sb
nHAKWX8VgIqbX6Gs98mQC0eSYigKznsS9amnoJz1cTHHCJanyAFPejfrOUNaJdNA
D3KGTN/H5uVbeXu/tjoF
=UcwJ
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

--===============3316355101158801818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3316355101158801818==--
