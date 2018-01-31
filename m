From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL]: kbl audio firmware update
Date: Wed, 31 Jan 2018 15:21:03 +0530
Message-ID: <20180131095102.GX18649@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8559795408442140935=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 92B28266A74
 for <alsa-devel@alsa-project.org>; Wed, 31 Jan 2018 10:46:29 +0100 (CET)
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


--===============8559795408442140935==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please PULL to receive the update for KBL audio DSP firmware.

The following changes since commit 2a713be25a44bd6cec90d8affc54b246a2ca9c7b:

  amdgpu: update uvd firmware for polaris asics (2018-01-19 07:16:32 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git kbl

for you to fetch changes up to aab8b6fff9417a9938f6393dc09cf6ce90e55565:

  linux-firmware: intel: Update Kabylake audio firmware (2018-01-30 15:42:4=
5 +0530)

----------------------------------------------------------------
Guneshwor Singh (1):
      linux-firmware: intel: Update Kabylake audio firmware

 WHENCE                     |   4 +++-
 intel/dsp_fw_kbl.bin       |   2 +-
 intel/dsp_fw_kbl_v3266.bin | Bin 0 -> 243016 bytes
 3 files changed, 4 insertions(+), 2 deletions(-)
 create mode 100644 intel/dsp_fw_kbl_v3266.bin

Thanks
--=20
~Vinod

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJacZGGAAoJEHwUBw8lI4NHSLwQAM2wurOlaUwdmv2eLQo4tFGC
OtOkVbM7ietbnMxMekGwQ5KBmJrxQZ4h3XR9mxt89cbL+H5Yv0PgjO3d3z9R/MTT
hRuZ3X8E68pCBYK4wtOxBteOVNHfd6S6CxpTY6p8uYqAxLghoilQ0tnpSKPL8cKu
gpFjfmQ6aevsPi6pbKgyyDg07B9dDjTtuhIx0Iz1maLf6Xcls2PD9f/whFM9aj9B
SVhwliXlezSKAGDunT8eV0G7M5laHZ4mcCn7k6TCYc0IPGNUXpjMR2/dAV89Dnge
cgO7yanL9cbI/+LBZ3tTGbyvExZrHAJdMTn9ODPzFnosIeknQOlqkJVnoRdYL9hJ
h2lBQfd4g3CTxAum0jzL3y+Og8J8AzQMMrZFtf0NP+4DHUvnHjNk1ZdNYClU7DwX
Qt+IY+RC3zW4/985ZU2wwBgZPy2QTwq9mD7AjwM6vpBEh/Qxw/EicptA9TuOHkr4
Ze6PgYJrQ/Ls/MujA/M1+jENAiR6392N0qutKepwMtCWFjccQblr8WxR/rqoc+Hv
zpXHaKGbVGgVvG9sX3NUGIsmjNfvJQeXv7lMZoYsH9mOd2Uiih27qUF5QQbBBSnz
euQd2SlypZwusxcG6W/B3b0zUI10fAmVhtTxhzz6rZegzJQILmmJrimcV6Q4h2f+
TQT3JNnLDhz/84qD4sl+
=WOnQ
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--

--===============8559795408442140935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8559795408442140935==--
