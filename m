From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL] Add Kabylake audio firmware
Date: Tue, 12 Jul 2016 14:56:01 +0530
Message-ID: <20160712092601.GV9681@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8717187771182855877=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EB87265451
 for <alsa-devel@alsa-project.org>; Tue, 12 Jul 2016 11:19:16 +0200 (CEST)
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


--===============8717187771182855877==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Please PULL to recive the audio firmware for Kabylake Intel SoC.

The following changes since commit 1dc99be22222fbf88adc98d85f8ffb7529c6c4e3:

  amdgpu: update vce firmware for VI asics (2016-07-11 15:18:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git kbl

for you to fetch changes up to 11e3390b4fac69b50a5f88861d295fd94e51ba6c:

  linux-firmware: intel: Add Kabylake audio firmware (2016-07-12 14:50:59 +=
0530)

----------------------------------------------------------------
Vinod Koul (1):
      linux-firmware: intel: Add Kabylake audio firmware

 WHENCE                    |   6 ++++++
 intel/dsp_fw_kbl.bin      |   1 +
 intel/dsp_fw_kbl_v701.bin | Bin 0 -> 238920 bytes
 3 files changed, 7 insertions(+)
 create mode 120000 intel/dsp_fw_kbl.bin
 create mode 100644 intel/dsp_fw_kbl_v701.bin

Thanks
--=20
~Vinod

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXhLepAAoJEHwUBw8lI4NHCCYQAKgpIlatsClA3um/Nziq5hRt
Rsak5q5cRHnUEaxQRl4IUUCEfHizc02NNx/9KDzg2opiMtbPXyZDPFnNpGxxK0FY
8Cpi/I54BiSMCgPNMOltuRVXWieWCh7i8VVKn6y/Bak1xitHMtZV8rRghbuhIrdJ
Z5lMFPAOgE8fGOQ+wlDc/42I3rQeyV0RQTmnUMxElEbhICKNqr2DJiXb/deB+KlL
ShC2iPPXpqLoU5M71KzsH3Z75Zy8RKJ9FVkPWwa6IRYjuRX1JTbAJhM6as1SgnEJ
J5JYWCEpeKV9XTk5SOgZX3RfMV+0W7yf9MaF5oiRKDK8O2Fp3YxxM0rbftYGKuDM
6SiOIqHyQydkgbHpVd90LVaWePivBGpktmA3uxzOzsCIOMvs8NwMjhGSe4xLOTlB
IvmVLZz3O2KqCdIZ0IX7VdOOWOPkE8nkCQ6kXMp38RL8g61imD8rAOmGziFjnjUz
4MvAKCT0cjFAYqTv4ZKnBHRlAo8bdGNDPIvmxULUcjPa9zTfMoRt+0Siai1ZqIpy
e0H/0V3dA9g9p9KfBKYsWkQaRttX/YnuPKqNaxGsh1UCoaUjQ6OYBO+J3CEEBEJb
u5RN00XQweI1zjt4j0JE9eEXUrGUYOJDyBNQxhnYa+kwG0L+UCKBl2X4m3561gP6
XbM4rrS7OTNgRtB8epNO
=/SPM
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--

--===============8717187771182855877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8717187771182855877==--
