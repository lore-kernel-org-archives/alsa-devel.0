From: Vinod Koul <vinod.koul@intel.com>
Subject: [GIT PULL] Add sst audio firmware for baytrail
	platforms
Date: Mon, 10 Nov 2014 15:03:58 +0530
Message-ID: <20141110093358.GD18555@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1753281702205929141=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C44426070E
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 10:33:12 +0100 (CET)
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1753281702205929141==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linux firmware maintainers,

Please PULL to receive the Intel audio firmware for audio DSP in Baytrail
platforms. This firmware is using the same license as another version of
the Baytrail firmware already available in linux-firmware git.

The following changes since commit 0e5f63771d0df6d7859f7c4100a74d737c62ac88:
are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/firmware.git byt

Vinod Koul (1):
      linux-firmware: add sst audio firmware for baytrail platforms

 WHENCE                |    8 ++++++++
 intel/fw_sst_0f28.bin |  Bin 0 -> 647078 bytes
 2 files changed, 8 insertions(+), 0 deletions(-)
 create mode 100644 intel/fw_sst_0f28.bin

Thanks
--=20
~Vinod

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUYIaGAAoJEHwUBw8lI4NHW7EQALDrZHkORJ8VTP1x7F15rbO4
vkYWGOi9hh7rLK7Vy8OPX1s7KN4zuKkWf7MPCj72VHPndY2c0bFiQ17SipkLrzFM
Cv61CFx19dbN4SnoUbaeOQkM4xBcKbYqWArMm+cyinILD06d1Lji4XhSnfGEATO7
Fitt0muUiRmCJ9NJ+yce3yAL9fome4ZOBSxE7H+SLiGCDrKkq411fR6PY1y9/MaJ
x3NL4QjZY1iiErqNvYN9sK6vjyIVNNRdjNOEmBanOpcgqvA58BgO5Jz6rZvmW4tJ
l5qvydO6563MzMqRm7nk4DO2LIk9ym5IWGeaLsNCdTdwDXPZSpoF2LMmYF1T2Hor
N3BF3qXrP7/k41VnYUax3VXyOgka0KjlkEdIn3+RB5TTmM93mScNoGEkGgK2yGQp
YkdEWXVvPmITkZsIdebTsu78ew8n+QK6kGuS3d5hJb5rhn3Hv23avzIFTxV/Jm08
0tm4fhq5MlNQ/mra4BijYn7FbZ2LHtycus923iGIuGQoIh0a9U1sYT34wWrNQ+i+
DD/VbZF31cGHjbXI/lH0TC9VAP4EQN7X67NsT1WcoPx4mPH5b6iFwdxZYIz2rihL
ip9vauMqcRSrEDySWkqL12wWhFWXFyKvEyXlEStmNAdG7QuZ1D5tp5jP2Wt/3d+6
ej7Njop+g4JrBltRvpFJ
=UGDc
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--

--===============1753281702205929141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1753281702205929141==--
