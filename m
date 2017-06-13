From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL] KBL firmware update
Date: Tue, 13 Jun 2017 16:37:31 +0530
Message-ID: <20170613110731.GF13020@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2863339195928329304=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id E79F5266C25
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 13:04:55 +0200 (CEST)
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
Cc: Patches Audio <patches.audio@intel.com>, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2863339195928329304==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please consider this pull request to get updated audio dsp fw for KBl
platform. This version updates to 9.21.00.2042.

The following changes since commit 37857004a430e96dc837db7f967b6d0279053de8:

  linux-firmware: add firmware image for Redpine 9113 chipset (2017-06-01 1=
0:22:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git kbl

for you to fetch changes up to cb8cdaaff39c1a453350bcd8c9fa4635661cc135:

  linux-firmware: intel: Update Kabylake audio firmware (2017-06-13 14:54:0=
3 +0530)

----------------------------------------------------------------
Subhransu S. Prusty (1):
      linux-firmware: intel: Update Kabylake audio firmware

 WHENCE                     |   4 +++-
 intel/dsp_fw_kbl.bin       |   2 +-
 intel/dsp_fw_kbl_v2042.bin | Bin 0 -> 238920 bytes
 3 files changed, 4 insertions(+), 2 deletions(-)
 create mode 100644 intel/dsp_fw_kbl_v2042.bin

Thanks
--=20
~Vinod

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZP8dzAAoJEHwUBw8lI4NHKMgQANA0xf3P11ma6t20yJYbXYq3
u2i6cxlfdvBRYnU8h2T1rLaVnDhWslAOMe91LA86yV+qypKkw3lnoYHI8MahlWEh
P25j89z87o4kxJkhaI8Z+LGTw7j89yloCZSCIdYQ9Fx7N/dHtsfWV3cULnID2Kmq
c+DbeVQbxxB26STGuWlgbedJks3dHrimh9H23cnlIqOxS8k6Lwo7lJfC2O+AYszn
iY5EX3Y4BOSufq7MYiY2bTwaiann3OmgJHMAdcGGwgAda4PeFWsAuSUvf/mSJIc0
lxaK+WsgaIb6hRF7WAZ4gCHiYyhdzWvhoTGCaTTeAuQGgHm/YjsaTe8EgnahX+QM
azdNnikPocbQXSvm7NUdz0CS9yfaXQbNuRlIgf17tp6deg8twNHL8KT50DK4cKul
33Ch+RZUjm+isyxhzgjcfhS9yK2aWCbeDSetm1Dk6qIsGpBIAmyQFyexUH7CxEhZ
7ACKKHyQfo8Hnop34/PK2mubrKSMc71HJXfk5DxGSPATfirL5v8P2ZNx9YyQXMMj
97L65iEMZGIZGIIIqg4dUEQabl7z1SjER1KpZPRPUNEdGaFsEr3b245o+TqDgLO8
BWAL+e5zdxmL35S45GguJRaOGw/Hu+fshbhOBwZrOtl+N3k57cybmd29ulsmwEVp
cqmUPGARS15loByalX2V
=L8VT
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

--===============2863339195928329304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2863339195928329304==--
