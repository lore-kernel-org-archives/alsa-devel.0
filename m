From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL] skylake audio firmware update
Date: Thu, 7 Jul 2016 19:40:11 +0530
Message-ID: <20160707141011.GF12591@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4983585171421816249=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 60806265329
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 16:03:04 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4983585171421816249==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Please PULL to receive the updated audio firmware for SKL which contains
update for supporting multiple languages.

The following changes since commit 3ef7857d511ce6a91c5ce609da76c4702651cfa5:

  amdgpu: update polaris ucode (2016-06-28 14:31:11 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git skl

for you to fetch changes up to d4274de33ed9448e91b970225ce9afdb74d5f13e:

  linux-firmware: intel: Update Skylake audio firmware (2016-07-01 13:10:07=
 +0530)

----------------------------------------------------------------
Vinod Koul (1):
      linux-firmware: intel: Update Skylake audio firmware

 WHENCE                        |   4 ++--
 intel/dsp_fw_release.bin      |   2 +-
 intel/dsp_fw_release_v951.bin | Bin 0 -> 221184 bytes
 3 files changed, 3 insertions(+), 3 deletions(-)
 create mode 100644 intel/dsp_fw_release_v951.bin

Thanks
--=20
~Vinod

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXfmLDAAoJEHwUBw8lI4NHBxkP/2jc6usxvSURv2+gdUHhzJ6W
0853a31IYviTeh/NztTrlert3sEzS03slkGdDAHWfNelsWHXT0+Wu3eEsmO4Hcym
hcNKQkZ5IOl4tGWRPOqx4vtjSOf7VHfHfhsEWV2OVCuI7rXBV814HGsrB70kgY6d
pELOUO3cWNOsXn/4+bOwF2Y0yh65NT8nLguMd6JmiV+pPrTAnIIyj+p2IdVsHrNk
Hvqh687/WY/Qt9Lo25JHE7dkJM/Z/jzRdtNRWR6ayiO02yLHhpJ0hVHbLqEop4hz
qjQ/SKEIBaUXZUdr63us+NZ9o1oYi6yCwzJhkng28rJD45SXsBY87Yh+859B0K+U
vvhUYj2qS/i+gBdn0NE9j00tkv9saVAWfOx6IMupjdW5jehDpRVO5jobw9WRzU36
uBoPn5pxmhyOLFTZ28mhqqOwJMnSHxJ9smztmUM1ODz7QZcOG153bc8JLdNyttma
0bcoqnwn982Du10Vzv3E4p17DAK0D7Da33tAtXFfC6xwoaa5Jyiu/pd7UhJpUthC
oVi3Zsncx+tyZxiah1FYwLqFdyHCUUQ+HX/Nfd/yHwEjMga91cRSfXQ6dj3n37fF
Jr4XmS5N3ZuzJJurKcE5Yru/riaiSdfPtCl2Z05MBPphFC1fYK8UlUX/hJaWgJT7
OCNA6JO+szpfSu8nzr+T
=5TmR
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--

--===============4983585171421816249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4983585171421816249==--
