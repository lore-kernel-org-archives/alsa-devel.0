From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: sgtl5000: Use specific variable
	for lo_vag
Date: Sat, 18 Apr 2015 12:50:44 +0100
Message-ID: <20150418115044.GH26185@sirena.org.uk>
References: <1429188717-6841-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3582767886643461243=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F5A7261692
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 13:50:58 +0200 (CEST)
In-Reply-To: <1429188717-6841-1-git-send-email-alexander.stein@systec-electronic.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Takashi Iwai <tiwai@suse.de>, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3582767886643461243==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GBDnBH7+ZvLx8QD4"
Content-Disposition: inline


--GBDnBH7+ZvLx8QD4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 16, 2015 at 02:51:56PM +0200, Alexander Stein wrote:
> This is a preparation for calculating lo_vol which needs both vag
> and lo_vag.

Applied both, thanks.

--GBDnBH7+ZvLx8QD4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMkUTAAoJECTWi3JdVIfQLZUH/2pJC6a2sGpEcvjwIM2tKL7S
IaYvZzpYW7ZS+pDepZDj88FUrG2IrQ9V+qcHol/lMHVhm5xQxQ3e5jseakbl6VO1
59v+PlkeZ9ghDc5na2/RZPXqusMfQ0gdePEKj5qk1eRFR6MFgB/dUBBJ5OS84Q/h
mmJhMlvpDEspfot/1yQa2uEnmmPo81PcQ7/pAcF8kLghqNQF/Pz4hXHZcRFJd7LS
lSd2ZfZKJ2zwDcFkgl33rwAiEvzYTidvtX/7P33SSL8RU12ATNO7aOJrbiSod5+c
bPF+lzqkkg9XBEdFHkLEZSws4ejHG2MQArUbp+adLbaWamBhCPJsu2sY2RnLUlM=
=/zod
-----END PGP SIGNATURE-----

--GBDnBH7+ZvLx8QD4--

--===============3582767886643461243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3582767886643461243==--
