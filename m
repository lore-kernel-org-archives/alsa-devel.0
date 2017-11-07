From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL]: Geminilake audio firmware update
Date: Tue, 7 Nov 2017 10:30:33 +0530
Message-ID: <20171107050032.GS3187@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4124479238997691719=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 8761D266E15
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 05:57:24 +0100 (CET)
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


--===============4124479238997691719==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please PULL to receive update for GLK audio firmware.

The following changes since commit bf04291309d3169c0ad3b8db52564235bbd08e30:

  WHENCE: Add new qed firmware (2017-10-09 18:03:26 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git glk

for you to fetch changes up to b964279f2d9955a6ce00d3a672b273ae4d7a362f:

  linux-firmware: intel: Update Geminilake audio firmware (2017-11-07 10:25=
:50 +0530)

----------------------------------------------------------------
Pradeep Tewani (1):
      linux-firmware: intel: Update Geminilake audio firmware

 WHENCE                     |   4 +++-
 intel/dsp_fw_glk.bin       |   2 +-
 intel/dsp_fw_glk_v2880.bin | Bin 0 -> 505608 bytes
 3 files changed, 4 insertions(+), 2 deletions(-)
 create mode 100644 intel/dsp_fw_glk_v2880.bin

Thanks
--=20
~Vinod

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJaAT3wAAoJEHwUBw8lI4NHK+wQAMmj7KWWkM269DUvYVQA8y6S
iQF7RdGd8K/EweWTpctdw5YgIVVbZW1o4ERrTGAArJz1G8yzn2E9Hsf3Sz2rmKYz
UD1CTOMv7IXtu1LMgKU4vIKTLYGumyLuLSBWR3s+pvW+pfP20Ctv3ww6mjsWkw3Y
U/VwjLVUYrfJn8CNuxTY8nE+zMsKiWtD1G0ET3WKVPLHcQug1i5VvPwORHgiOAAT
h+R3E1KNyPHpt37bFFhD/B9hAFWgMmaSV3I3EV5Fh8+NEFYAqzR+ybY7w17LQByM
zL+seH3MlUTdNDmYco9eYm4xPiln7Ozz8LMWZyLxoIaAzpH3feFvKSMkLCAx1Pc+
W4ULR52wB7fTNPXC+hBeuLaGU1GYa94ionbT+Iw51gcuLKaogQPO0pzz/dXgezUj
Pe2SMuNqYctFaDSVMsOkzGP4ZzlUCgTwDdLMvurPo2z+9FrKkGhDcJMBIr0EOCqa
9fCZoNPWWnsO1uZ0BshB54zMZTc8UvBQTckfmMGxtPjQEP3A9mp4NhOlzgB6ya/2
0uP7B76KGN/VRmh7nMjNMhajKNDw4HbyOz8EeXqVCMJeXqvFSQ79w3vwOgp0BMgn
cRUrALGZx4p4O2DLZ2fs6oL170pZI4k0gn3iUE27AW7H1hfVCBAFel/IeBY00oJ2
VjG12+RbpJ/GYQUIn5Jg
=VRsk
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

--===============4124479238997691719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4124479238997691719==--
