From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL]: intel audio firmware updates
Date: Fri, 12 Aug 2016 17:16:27 +0530
Message-ID: <20160812114627.GM9681@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5144444314481140238=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B7FB3268718
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 13:38:43 +0200 (CEST)
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


--===============5144444314481140238==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bzq2cJcN05fcPrs+"
Content-Disposition: inline


--Bzq2cJcN05fcPrs+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please PULL to receive the latest Broxton and Kabylake audio firmware.

The following changes since commit c170c8d95794d6aedbaeea44674daaa96baf04f7:

  linux-firmware: intel: Update Skylake audio firmware (2016-08-04 16:09:21=
 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git apl

for you to fetch changes up to 92b8db544104bf8f4fa8b5b2bea2f3681ed2e713:

  linux-firmware: intel: Update Broxton audio firmware (2016-08-12 16:07:01=
 +0530)

----------------------------------------------------------------
Vinod Koul (2):
      linux-firmware: intel: Update Kabylake audio firmware
      linux-firmware: intel: Update Broxton audio firmware

 WHENCE                      |   8 ++++----
 intel/dsp_fw_bxtn.bin       |   2 +-
 intel/dsp_fw_bxtn_v1118.bin | Bin 0 -> 505608 bytes
 intel/dsp_fw_kbl.bin        |   2 +-
 intel/dsp_fw_kbl_v1037.bin  | Bin 0 -> 238920 bytes
 5 files changed, 6 insertions(+), 6 deletions(-)
 create mode 100644 intel/dsp_fw_bxtn_v1118.bin
 create mode 100644 intel/dsp_fw_kbl_v1037.bin

Thanks
--=20
~Vinod

--Bzq2cJcN05fcPrs+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXrbcTAAoJEHwUBw8lI4NHLNIP/0LeqhFUJkHI8Ql0ZwNxRtwC
4ArXdHJ87fQyVUzpfc0LRTgAHt+c7ASmQx2JNgavIX1dH7qlWe0ea1ION9yMdSeR
fHvfauZ+kl7yN36LP0qlULlpEXG4nT7pGtZIOeHygnToq4bxsJvM8unSaBG0dc46
TLWvGUkTQDMdupr7dobcWpdgMZipljyqdrGcVSiUZ6dAgQwUmwOwIuqflbaxY3dr
Vi50PFYJUSHNzXqly8fdbnTvLoRLQeBWzZXHyn2Hk6kOHakiyBm3FMBWAER2PhYR
X3x0qLyW8sZl5T8c/DNHLh+AjuvNAx5t7xRC5bh5EwM71lqsLeR05BJbcMu88H9A
tZumgQ/ZpwtZZNH6TqiLGS9sPczzG+PL1q0KvzIKoFSGRUksvSITJLPkPNyDLt/W
2Fg3sRzLDe2sSLmcNJ6sHkqkwsF2fZwTTqA2n29DP08VkaDLZum7OEFvCdBHF7J1
xxkcCNonr7O7eIvCOn8JzKEvD5TrwOJSqsT9oAkPLqEK6M59f7aq32Kwsu7uNJKG
Nez4QuczOol99Rn9kZ6wQcSygz2SOWE3e4Zi2JFtUaeVBZ2wITpK/PTaBQ2vcuvd
8TakTFnirNJRJxxvcazhb+1hFkmmPRZK0bvcl20UgpqnBZK/pCrkCKO96S70a4cd
OuTG1Jk/IHgA0uMP3vv/
=Vj5i
-----END PGP SIGNATURE-----

--Bzq2cJcN05fcPrs+--

--===============5144444314481140238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5144444314481140238==--
