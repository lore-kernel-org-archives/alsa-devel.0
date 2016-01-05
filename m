From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL]: Update sst audio firmware for Skylake
Date: Tue, 5 Jan 2016 19:18:48 +0530
Message-ID: <20160105134848.GN2940@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8783222643429853702=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C1055260710
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 14:45:22 +0100 (CET)
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
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8783222643429853702==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Content-Disposition: inline


--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linux firmware maintainers,

Please PULL to receive the updated version of Skylake audio firmware.
This version contains some odd fixes and support for MCLK configuration.

The following changes since commit bbe4917c054eb0a73e250c6363341e3bf6725839:

  WHENCE: use https://linuxtv.org for LinuxTV URLs (2015-12-07 02:17:20 +00=
00)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git skl

for you to fetch changes up to 177d9f030b4eef981570fc2ef0bf9b0b922d99df:

  linux-firmware: Update Skylake audio firmware (2016-01-05 19:07:52 +0530)

----------------------------------------------------------------
Vinod Koul (1):
      linux-firmware: Update Skylake audio firmware

 WHENCE                   |   4 ++--
 intel/dsp_fw_release.bin | Bin 233472 -> 233472 bytes
 2 files changed, 2 insertions(+), 2 deletions(-)

Thanks
--=20
~Vinod

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWi8nAAAoJEHwUBw8lI4NH8l4QAJyZNToq5By/eIvHlvzJk959
eTmj4f5ODv4Sedczz71y7zHrONp6YrMPtut3sTOFPJI1VDGGlZ0c6NybuZFIY4Q2
K0rNbc/YS4r5kdsSVb5sA0sI5WAv9NIwlLZWWBkhYSZ0j7N+PUscbYhceTiGusl1
rYgfw+Pi9NpQyLMgNPlEhHomqTRjSi0EyFkQrKv2qm0KQWl8nlPa9MCbZ9CNjzeZ
tY+p7Eb2GZp9CaOFr/bqnFDi42NLxu4HIK/Arom31XL6RR64rk2GC6bOHvKyluAv
baicPpAGFXate4PvUPxkDwBinZ0u8oOPyGknB2x/sozdbNAcBWj8Z9aKiGY+18MM
JJJBJrBP7Utlqh7Oczfb2I485fUDeEFpJq3hpNrfgDyT+NrfJk3Si3F+pyhjmCWY
rEb5iZKUsukjzz8IFixgmp20x/iyShF/BWFOUmuz3uxzVEvt4zYeaZa4LcHo8+o5
l65kTUIM4yExkW+PnjC9OhLSnAEGzbc9zM868cWdQpWK/Pp9ImHuRXUZsFyFnWb6
Wqq55pZRqTHuQwA73sBo2BTrVy0SHFPFaesktI8I4IBTE+8KcOVluEO5/IEbaHYU
D6qV+aRVfIg9OMXLn05AjERDqk61J4P5c12Uo20BX4IiOP89RLQEWNfxyLxiiLRH
Ior/b7JagUUaT9+reR1N
=M9NS
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--

--===============8783222643429853702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8783222643429853702==--
