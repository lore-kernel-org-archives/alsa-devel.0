From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL] Braswell audio firmware update
Date: Mon, 6 Jun 2016 14:29:52 +0530
Message-ID: <20160606085952.GY16910@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2950019546642627053=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EC1C26574A
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2016 10:53:17 +0200 (CEST)
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


--===============2950019546642627053==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Content-Disposition: inline


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please PULL to receive the updated BSW firmware binary which contains
some odd playback noise fixes

The following changes since commit f5b546819836f207a6df58d48423ca6112cd2801:

  linux-firmware: Update firmware patch for Intel Bluetooth 7260 (B5/B6) (2=
016-06-02 09:51:44 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git BSW

for you to fetch changes up to 1d079ff33967673e9de44f1ac33de8b62f021b32:

  linux-firmware: update audio firmware for Braswell platform (2016-06-06 1=
4:24:20 +0530)

----------------------------------------------------------------
Vinod Koul (1):
      linux-firmware: update audio firmware for Braswell platform

 WHENCE                |   2 +-
 intel/fw_sst_22a8.bin | Bin 701614 -> 701694 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

Thanks
--=20
~Vinod

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXVTuIAAoJEHwUBw8lI4NH/iQP/RYMgE8/tuBhNzNn61NzvHoQ
kiSETq8e8uqaY88fibnYtp/62w+q6AysjKPCxcxVO8cYQTqUQ4l6FL7qAXXPuUor
0SEaLwi5VJ9EjOAyZJB3+T+j8ghJaV+d6k17JlVOwv1zkLQNJsxwWOmzZq+WFGK0
HzsneoElZwL97YFoEBI18nA9tWrMSWytxHCmgOqKGhU3ozqCRWdZAJG5zaMkdT0d
nnVvniheQfCsu+StDBG+a5f+vL7OL1m6PZ6zt3XRZZiO0X13oa2gft6i6Z8dhEHl
ayldMB104RQ6g9J7/NVcNOZSjIhfpTIk9Ro0+xUnLXNknq2dl86h53su8Ef23XWM
qAGCQCExBz85Qfl/utB5Akdg4kfxsOV945+j2nTau27YVziuPBRFadN7wsAwOun7
WeKP6bJa8RI6XPj/+Vr2NDZhpsf4CEHZ1iQbANXB6ATLLykK9X9sQ/7di3TsPD8o
7fIIW59Z+Qt2bpoxKBSdGMB09l41++7i7yWOGWFfmQCj8RliqpH1sseQA/tMc1cQ
ZCm8wwhWCnhZJK0rndSUpGihA/ZlOU/8OfW6g4b4C5N81D9R4/N23WpK6nsePV9X
vmFqYdnhmxb6EZQb3v9en4x1MPcHMYuJdz4IpELKSaAxIT34kOXHd/K1pnIe1eZc
CasXwbq45xpV5ebR2jTJ
=JE2w
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--

--===============2950019546642627053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2950019546642627053==--
