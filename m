From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL] Gemini lake audio firmware
Date: Fri, 3 Mar 2017 19:05:25 +0530
Message-ID: <20170303133525.GT2843@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5632288120352090573=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 35FA3266AFE
 for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2017 14:34:32 +0100 (CET)
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


--===============5632288120352090573==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please pull to receive the Geminilake audio firmware used in Intel Geminila=
ke
devices with Audio DSP.

The following changes since commit 4b9559fb0565f582a21a4070a81a3b6a7d77610b:

  linux-firmware: update firmware file for atusb (2016-12-07 01:01:04 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git glk

for you to fetch changes up to dc76591484e43cc031a28eeecae68196a98a1550:

  linux-firmware: intel: Add Geminilake audio firmware (2017-03-03 15:40:35=
 +0530)

----------------------------------------------------------------
Subhransu S. Prusty (1):
      linux-firmware: intel: Add Geminilake audio firmware

 WHENCE                     |   6 ++++++
 intel/dsp_fw_glk.bin       |   1 +
 intel/dsp_fw_glk_v1814.bin | Bin 0 -> 505608 bytes
 3 files changed, 7 insertions(+)
 create mode 120000 intel/dsp_fw_glk.bin
 create mode 100644 intel/dsp_fw_glk_v1814.bin

Thanks
--=20
~Vinod

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYuXEdAAoJEHwUBw8lI4NHyMAP/07ytOxkE7wsT67fNcAxyfUe
kh7BAncbUT+aad/VnHaHK9m6h3adSihPQvIrnPnvcrmZ2cv6bsix9nKfzbP15kTq
Xs7S0+7ek8h9r6dADpvHqeZZKx7HDlsS/MQOedu4BxmQ15jU7ynUtcayHzZRCoGp
7uA2FrU9Ls6RJxbHAp0PgI0v2mykaJbZG3CTKr4Wi6V+3nAyCbRhTfA/vPCGhqum
jMtnn7149Eh9tB6AC+iXEd8GyPGg8x+ER6IPmqERze9E3DkGPFJxDApCh7ucbWhW
AN7cD+6nLo4xmOUI05X5iNWIjlaQaCdnGTgyvavRAJI7jFFyp+Vrwnib6+n+p2G0
vThknE8mRKacRfbvQ3BVDum49z7iGHni2AxaZB6XczH0nzP0lWnyNbZePmpW1JtT
MWXsGEm6hTT40PQZEDzPmvMyLomEsLW0kzOkhzWzPvO4A7EVSe1/DjOKF+h22rAY
QIdZGhfWjN20lV9xQH0hmIdOahl82obgKEpL8E90e8hVJhSgcBKCW8nHn25rsODF
JiyqiDc8P7k8wq3WFRRpzGnq79zjGSS2DnxooZGcbTKk3HQrUKpysh3gt2q4NStU
eY9mBY/MzvR2WH0jBjgAYGFwNIQG5EaFMupLogeI98uJXkQt1cOnf+KwgHzHmrtk
asXApL8nrDaIAJRu01FX
=rmbz
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--

--===============5632288120352090573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5632288120352090573==--
