From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL]: Add sst audio firmware for Braswell
	platforms
Date: Mon, 2 Feb 2015 21:40:58 -0800
Message-ID: <20150203054058.GA4489@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7631677560908306365=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 950402607C8
 for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2015 06:42:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-firmware@kernel.org
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7631677560908306365==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linux firmware maintainers,

Please PULL to receive the Intel audio firmware for audio DSP in Braswell
platforms. This firmware is using the same license as the Baytrail firmware
already available in linux-firmware git.

The following changes since commit b794c5039dcf0b7ebfeb58929d035f7a1d4c80dd:

  Merge branch 'marvell-mwifiex' (2015-01-27 10:42:47 -0500)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git BSW

for you to fetch changes up to f692aba54c8c80cb27a3eb5388594a55a30504ea:

  linux-firmware: add sst audio firmware for braswell platforms (2015-02-02=
 21:12:22 -0800)

----------------------------------------------------------------
Vinod Koul (1):
      linux-firmware: add sst audio firmware for braswell platforms

 WHENCE                |    8 ++++++++
 intel/fw_sst_22a8.bin |  Bin 0 -> 647390 bytes
 2 files changed, 8 insertions(+)
 create mode 100644 intel/fw_sst_22a8.bin

Thanks
--=20
~Vinod

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJU0F9qAAoJEHwUBw8lI4NHP/IP/1nyzQ9SDj+O1hZQ5OC+oBvV
tsLZLuUG8Krq3YFeI7uKnoC84bl/rE5Bm+bCy5hk9FNBLVCEbrmVQAiDX5178UCt
iY5Y0+uLOqD7cBsDWKbaBONEgzlHz2abDMNUBMMwPRR0+ck8+AaBfRdONCpJwqZw
lZokuzP0nIC6QivRZp+0eUPJ47ASRVirQJs4ZREHZbAw8pVtdi1sLngKio0Hr4k2
dn4UqYz8kt5L4JYov5LJKZCQzUaRdgdEkpo1RoPFSlHCyni9/YhZJxTREgz99nZF
p2kmicYdfq9T8yMVxWNjcHnm70IK+fxxwwaxAtYh/g/J7Ulxp0vLHyyNXFeIyNZO
rssPEeC81g9d9clLnbSkJ9e1FRuejvttzIV86+sV6WBuy8dgZtAJ9xQeJHc7R0gS
hykDFiBJE9abrgxwJdE6OjT+CK5qC9PbRcigGZ4Kincpu7F7T4b+YPNiFHrWefWI
tyvk0FIhc1HfLMIjYgLmX3GOTbKo188+n4G6vZL74v39IwG2aN7Om5ZEnTSFzEaE
jQqPckF91YEgyeL7k8LmPcvmX0WuI3Cys2TGMskjt+s6dF/qOIrTLwt99ObJ2vwU
3NWF5Ppmny/p5hz6Cq0hZg6n9+/Fb0H8yu0OK7ItGWJYvXKyNDbNGBgwWXk3PepD
wQpjhytoAyHsT+i47dfk
=hDkz
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--

--===============7631677560908306365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7631677560908306365==--
