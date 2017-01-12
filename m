From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL] intel: audio firmware updates
Date: Thu, 12 Jan 2017 15:19:23 +0530
Message-ID: <20170112094923.GK3573@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8502470752830859065=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D5B3266639
 for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2017 10:49:22 +0100 (CET)
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
Cc: Patches Audio <patches.audio@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8502470752830859065==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please pull to receive the updated versions of skylake and broxton firmware
binaries.

The following changes since commit 4b9559fb0565f582a21a4070a81a3b6a7d77610b:

  linux-firmware: update firmware file for atusb (2016-12-07 01:01:04 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git skl

for you to fetch changes up to 4529fb4b320ba8e71a213723d0ad029058b15912:

  linux-firmware: intel: Update Broxton audio firmware (2017-01-12 14:58:44=
 +0530)

----------------------------------------------------------------
Jeeja KP (1):
      linux-firmware: intel: Update Skylake audio firmware

Subhransu S. Prusty (1):
      linux-firmware: intel: Update Broxton audio firmware

 WHENCE                        |   8 ++++++--
 intel/dsp_fw_bxtn.bin         |   2 +-
 intel/dsp_fw_bxtn_v2010.bin   | Bin 0 -> 505608 bytes
 intel/dsp_fw_release.bin      |   2 +-
 intel/dsp_fw_release_v969.bin | Bin 0 -> 221184 bytes
 5 files changed, 8 insertions(+), 4 deletions(-)
 create mode 100644 intel/dsp_fw_bxtn_v2010.bin
 create mode 100644 intel/dsp_fw_release_v969.bin

--=20
~Vinod

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYd1EjAAoJEHwUBw8lI4NHEukP/0mxPIoQX3UxqeeFifOsQjiq
c/ARI2I5sl/hb46u6cIAqXMPxA46/q2+4xJKMU/TFlYhUsDXIFc5rLITZ6HaeBDz
mjNAXCCbslaeswlAQWl7NZPR+Xbm++okXggjC5bSeYOH0E/AnhMG2O8qr93eXc7y
oEnpYRK4fQEzdwlMUNzUSa7ehCXIJ/ERRM4eEMPYSwtgLnYO1xMADdbGNi2Heage
ECpTLiix0Vf4jzQ4e7YHuiP+5IRQwOIx34qiR5amNEDKoMNCX3DL2K0OlcS+G1M/
bbdxRRXGa552tMVqzm9Wau8jXgFrI8zPp8wml2sgQTnzccqL9fFN01CvrRSpKxgq
hlojmOWYWHGUTejHuvQvoO1XPC3SDYem1qbZ6pf0tp9280x2vW62AaYn91qYGelQ
A3IaF/x6UgXWPrbnwMHl/XQLZDcJWqBq+K8UjYMwpoAgmwxe3NpdnMLxXL+5V94O
LH0E6l2vfbN8wtFXqvt3QMl6mt/B9OmkSOakSf8FZQn59qdn/nHSDUlyHQzUvNT6
+UgrLrnmHixcmUOG1y3kPakLviB3MrEhCcQped2t8k9PHLBWk4pXFeBHVVM7JVo9
nm4h8FYOLeF+KCQE+uEwuVp8c8FTtdQZbCueclFvRNSPOzNf3gXsSusROTsmOyNn
eOmSbvwFZdQpqgMiXwNb
=TT8o
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--

--===============8502470752830859065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8502470752830859065==--
