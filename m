From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL]: Cannonlake audio firware
Date: Mon, 4 Dec 2017 09:13:03 +0530
Message-ID: <20171204034301.GB32417@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5627999278196060970=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5703226710B
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 04:39:27 +0100 (CET)
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


--===============5627999278196060970==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please PULL to recieve the Cannonlake audio firmware.

The following changes since commit 17e6288135d4500f9fe60224dce2b46d850c346b:

  brcm: update firmware for bcm4358 (2017-11-25 10:15:53 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git cnl

for you to fetch changes up to 89c62115f14dd8f414dfd2702913a6f1fcac3287:

  linux-firmware: intel: Add Cannonlake audio firmware (2017-12-04 09:04:57=
 +0530)

----------------------------------------------------------------
Vinod Koul (1):
      linux-firmware: intel: Add Cannonlake audio firmware

 WHENCE                     |   5 +++++
 intel/dsp_fw_cnl.bin       |   1 +
 intel/dsp_fw_cnl_v1191.bin | Bin 0 -> 583852 bytes
 3 files changed, 6 insertions(+)
 create mode 120000 intel/dsp_fw_cnl.bin
 create mode 100644 intel/dsp_fw_cnl_v1191.bin

--=20
~Vinod

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJaJMRFAAoJEHwUBw8lI4NHQqIP/1HU+8zaVkE0YmYSHs1EeiSx
P4i8gw8OkBGjy06sMkRdllYxm14p4cV4VlBZKl/GwZEOg20CN+JbXaIBrqygvh6j
aM8avaCvo01BiS3LVpmWEnMRvPR5c18PDW1JX6kWNlmsOBHjmHgbtpqcVzgyrf5z
ea7oPC6mNE0Yv8UQzFLreIxVT4xX7F9xGL8Roee4FSjbEAM9XNgdvAeDoz4pYW5l
lt+9P6cYOdvqFZtLxj8vIHobD1QWUvPdH1cEeqjXJAHbgTiFjCxoQXRYaB+T3B0M
qtBKCsn0LKPQ0nLI15AUo0+OH7U3aj6pEdLb/ou8udd/xp6ASDYhS+9UcgN6qHPC
OzyuPDclGeiyfGShCtDwHbO/Eso45ke2EuosyCw6285VVfyuq/ksq6eB+dvSynSq
xZPJ/BJSK/pQmgtZ98kyyWr8R9tY7tO5wmKmlz54iliNdGdsbgBgoh6aBcdSbvHm
b1IfaD7YHUTDdMrtoMIcsXKwatqLFmJ4y1WYN6whNJLykJfw3A/EruISdHpFQBjm
CpNSqxn43FjbN+bhtU/uwJIMUX+2RsGV5AFr7bJLdBrqVKLQWN7vQtWotDy4vHfJ
0t/zZSFNTXkak+4Ma4twKKmSqBK8ga7zYRSnEj6Ea9LKuGbsCYhN9Pv+YiQxjCvv
sjcwWNmk2x28DQymd8/M
=QN5i
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

--===============5627999278196060970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5627999278196060970==--
