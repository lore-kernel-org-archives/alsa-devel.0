From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL]: Skylake audio firmware update
Date: Fri, 17 Jun 2016 14:09:36 +0530
Message-ID: <20160617083936.GF16910@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1897543601863130637=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 21EB32604EB
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 10:32:50 +0200 (CEST)
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


--===============1897543601863130637==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CKf/2jVYos1l2hij"
Content-Disposition: inline


--CKf/2jVYos1l2hij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please PULL to receive the latest Skylake audio firmware.

The following changes since commit a4bbc8112cc04fcc0e0861e8b72197b6cb83ab83:

  linux-firmware: Update firmware file for Intel Bluetooth 8260 (2016-06-09=
 08:11:22 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git skl

for you to fetch changes up to 80aae2270140807c4d8e304c39def1fe9f93edb9:

  linux-firmware: intel: Update Skylake audio firmware (2016-06-17 14:01:52=
 +0530)

----------------------------------------------------------------
Vinod Koul (1):
      linux-firmware: intel: Update Skylake audio firmware

 WHENCE                        |   4 ++--
 intel/dsp_fw_release.bin      |   2 +-
 intel/dsp_fw_release_v948.bin | Bin 0 -> 221184 bytes
 3 files changed, 3 insertions(+), 3 deletions(-)
 create mode 100644 intel/dsp_fw_release_v948.bin

Thanks
--=20
~Vinod

--CKf/2jVYos1l2hij
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXY7dIAAoJEHwUBw8lI4NHiX4QAK98BZSFd3tfptsvqLF4MHnf
GVvQy4JnSuAl7HjqW0q+864qKlMG+Cte9vMrbesY3QuziTmZGxkpQkLwB9WyRxEV
btoimNqAos+bbjKvUNVrVTkLiAlw69NXZrnd3bFuSdsr39FwP5KUduBmmRTPru40
tdDCE87Bec2ulTUY5Xmu8FcvqB36An8SnGWXYdf3/DViFW6BUNNnzrsAINSSr2xB
8ood7rk5ZaaW1/Tr/3rJBIDzXXLu1sFeXZhz0KwIQUpkKLRdwVBGnJ2hTXdkAXdP
0JWn2yzhfBqv9SxPa8boHghesZLyZA0HXkCANA87flgX2tzgEsZIzSwQesxEMCBs
8y1YxFAQ+G1VBm+3W9XpE09v4IdLkrrp1TCzYKTD+IkCpAPoluPtlH3SXx54RInW
7Pd4vfIk/DLwqsI8yKJtc9h3yQxStIx5iRzyTGNLCv59+9kmTmPm7E/KppdlMF4o
r6hRcyQN11Z3tByn0318h42p+GPMJvCstWf3U4CQ9HEglMc1TXFfDiEbaQMJMo4k
3NYLw8VgFGbvyvNkKO8IK+qf+ywosTlT6cUfm7EEg0D4QM6B8PvdTLDahjMngMib
qNJ005fFiHKNP0ehyyIRstaCDm+G2Bb0BmxDp+yYPhbeAYa/txxHd664Jw+IHaTw
Ga7ifJE7ugKmkjkqg+LN
=B81U
-----END PGP SIGNATURE-----

--CKf/2jVYos1l2hij--

--===============1897543601863130637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1897543601863130637==--
