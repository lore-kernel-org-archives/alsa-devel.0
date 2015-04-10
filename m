From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ASoC: Intel: IPC/mailbox code
	refactoring
Date: Fri, 10 Apr 2015 19:03:26 +0100
Message-ID: <20150410180326.GR6023@sirena.org.uk>
References: <1428370412-15155-1-git-send-email-yao.jin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5601342734120722537=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DFB8E260642
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 20:03:40 +0200 (CEST)
In-Reply-To: <1428370412-15155-1-git-send-email-yao.jin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jin Yao <yao.jin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5601342734120722537==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PFqVN64max5xpiI3"
Content-Disposition: inline


--PFqVN64max5xpiI3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2015 at 09:33:29AM +0800, Jin Yao wrote:
> Hi Mark,
>=20
> Currently in Intel SST driver, some very similar or duplicated IPC/mailbox
> processing code are used in different platforms.

Applied all, thanks.

--PFqVN64max5xpiI3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVKBBtAAoJECTWi3JdVIfQtG8H/3X/30zVtvvClJVriPO/d0YZ
5u5okbDlxM8ZZyMqMmKWZhQwTAg9O0xWTPjE5K+NrpzI0aT9TC69X7dnm7+wTGv/
WLikpO1g16KcVPtejCXMgUb4o5oqBQ/qjPeBI9AX8Q/lMZOB7+LUhDbB/R+/EjZW
gVrhfqD2n9Xh2VFnl8J+VqWlLUnHBgVp9sB/11w2nwEFiLD2ScZyND4BDGmX96ST
lU0vvK4Bo53NNvNW+J7mkGIuLFayRYCFconzqJbZV6IZM/pIrVZ0lD8nGi+8pDll
hD0IPPpXaMW/g9kg+DP1GG+nHRGu7Ro+wcBdgsHsRm6Tr+Egov9EadJfkMd/kxU=
=7zQw
-----END PGP SIGNATURE-----

--PFqVN64max5xpiI3--

--===============5601342734120722537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5601342734120722537==--
