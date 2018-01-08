From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL]: Geminilake audio fw update
Date: Mon, 8 Jan 2018 16:02:24 +0530
Message-ID: <20180108103224.GC18649@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1114462584508125860=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C6592668F0
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 11:28:13 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Pradeep Tewani <pradeep.d.tewani@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1114462584508125860==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please pull to receive update to GLK fw consisting of few updates and fixes=
 to
this firmware.

The following changes since commit 65b1c68c63f974d72610db38dfae49861117cae2:

  wl18xx: update firmware file 8.9.0.0.76 (2018-01-04 10:06:01 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git glk

for you to fetch changes up to 6ac6d57bdeb354a11b21a3ee5a00f6852cb57fea:

  linux-firmware: intel: Update Geminilake audio firmware (2018-01-08 15:56=
:55 +0530)

----------------------------------------------------------------
Pradeep Tewani (1):
      linux-firmware: intel: Update Geminilake audio firmware

 WHENCE                     |   4 +++-
 intel/dsp_fw_glk.bin       |   2 +-
 intel/dsp_fw_glk_v2768.bin | Bin 0 -> 505608 bytes
 3 files changed, 4 insertions(+), 2 deletions(-)
 create mode 100644 intel/dsp_fw_glk_v2768.bin

Thanks
--=20
~Vinod

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJaU0i4AAoJEHwUBw8lI4NH6mUP/ivgK+GmFbt6PmZrCy8or7S3
b18rKmRZ2OQKGN6qpWRH5fUKWsjjA7laskw980A8IJJcuMqU9iVpswQmNi+Pgm5U
5eVX4f0W+NR1Op9hezgIj+kSovNZVcoRFvqtrn6XJ8Aa5RhErQqgHjNU/7rPRdaY
pkH2TIcyvGtKri9hflsDXAZ580ISmNENp2Kjl+DukIWAbkbxO9VKCU8NBLd3Ov5F
LLUERFlaQ/NjdxoYYsjIklujXTW6jx4nTZvhO6GcRYyEUt1nyhv7+m7oFLj8/aWs
j7S9WJqTjaagn38FWyVVf6C9IcepcQTRiSI52zO1vZgo/a5zAhAJ43NNbUVq67K7
0Vrwzc/TIQLk4TijcAIdeFx11KtsRtK3kA1NvNU8sjBbytLQXoeQzZy0JWiU5keh
D5XZTPXJGiXhPW5WbwPUFYGNOYDvfiRiaSNOprcqusVbaytSjzROJjvtQXOgVEc1
BS8i/ivKrkucudNhPinDz6qMj4pYXTKi3isnqK92iCfg2tfPGzDPZeXXMy0iasZG
8PbrsqaLlNQtJppgJfqDY217cpU3gMwnt/ZaNrj68dUstUyUFRJi1u4+k1FaUpK5
o3vlF44P0dlfjlnv3DXoUhf4e1ZBVIK6grw2+nFmMai3N/Ejwauwz6N0IzrPvD06
X6Des58HckitvhYg9HaD
=WwPj
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--

--===============1114462584508125860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1114462584508125860==--
