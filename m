From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL] Skylake firmware update
Date: Thu, 4 Aug 2016 16:13:51 +0530
Message-ID: <20160804104351.GC9681@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9159490189306017029=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BEB61266DD8
 for <alsa-devel@alsa-project.org>; Thu,  4 Aug 2016 12:36:16 +0200 (CEST)
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


--===============9159490189306017029==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqCDj3hiknadvR6t"
Content-Disposition: inline


--AqCDj3hiknadvR6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

Please PULL to recive updated Skylake audio firmware.

The following changes since commit 6bc2c609988823744d1a45d33ee370c8310ec305:

  amdgpu: update stoney UVD firmware (2016-07-29 14:40:03 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git skl

for you to fetch changes up to c170c8d95794d6aedbaeea44674daaa96baf04f7:

  linux-firmware: intel: Update Skylake audio firmware (2016-08-04 16:09:21=
 +0530)

----------------------------------------------------------------
Vinod Koul (1):
      linux-firmware: intel: Update Skylake audio firmware

 WHENCE                        |   4 ++--
 intel/dsp_fw_release.bin      |   2 +-
 intel/dsp_fw_release_v958.bin | Bin 0 -> 221184 bytes
 3 files changed, 3 insertions(+), 3 deletions(-)
 create mode 100644 intel/dsp_fw_release_v958.bin

Thanks
--=20
~Vinod

--AqCDj3hiknadvR6t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXoxxnAAoJEHwUBw8lI4NHPEoP/R186tKMJ+ys/uhyBB8Uy0Kk
kxuQrYRDxoPJpbv/zjWwSQHX6bJYnUdquNf6LUXRNdSf9nlB9qL1DQqU5iDOsAJ+
Vp8MtMxkig+7AZE/H/GKc8kjskWFNCFhzxcmAgGttaGla5mpRBbFveI3omEQc2gV
0/R8qKDz67lz+8OR2TM5vyP9nC+QjAVz3sx55046IH0509TEpgH5PbxT/JB3PdW/
+tj7dgAkTEpjUigUQILzOLFOx1/VRII2poAipSdr9tJP8vLzU92RKCVZOJtL3ZpA
pWHUeMlNavgxpwMakgvYBWEVZY7CAkD505TgRWHrUlKxbzbzFoCVaO7y+DJYNLCQ
q2g41jLpATZDQOD6454Hrga1Jlz44qGOHxUZxG3lykzscK7b5n8MsE/tkZnqCdHL
3krhJP/V5fZGGxgZVqfZ6S9YtQLFAVVvpGGu4TKbV9SBNfHRnJeYZXBxk6P6J8Mw
4HSSJxsG032nOw7Hcy5TEIGAf42e0vMFI/rlsHQH46JcFhcorpfJVm6cyU0+Wp0t
absOctxLe4tfO6uBBaFBJE2kDVVSkL9v9gFTc8/s30rN+oCcRX0cEbkghnasJOLO
e8bpWjA4J0rZNo+ojuEt+Ggmd3Q8KQ+iSS7U7Lkr38nE+bi/720v6OZ8O7U2D0qj
gYIkvsuZQKDwxJ+jyG+O
=2UxV
-----END PGP SIGNATURE-----

--AqCDj3hiknadvR6t--

--===============9159490189306017029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9159490189306017029==--
