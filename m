From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv4 1/4] ALSA: Add SAI SoC Digital Audio
	Interface driver.
Date: Fri, 20 Dec 2013 11:55:54 +0000
Message-ID: <20131220115554.GR31886@sirena.org.uk>
References: <1387501387-2151-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4065777973151634231=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 60A6D2655E4
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 12:55:56 +0100 (CET)
In-Reply-To: <1387501387-2151-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, Alison Wang <b18965@freescale.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4065777973151634231==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GUWDakHTpZ9AxSMt"
Content-Disposition: inline


--GUWDakHTpZ9AxSMt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2013 at 09:03:04AM +0800, Xiubo Li wrote:
> Fix the description of one comment.
>=20
> This adds Freescale SAI ASoC Audio support.
> This implementation is only compatible with device tree definition.
> Features:
> o Supports playback/capture
> o Supports 16/20/24 bit PCM
> o Supports 8k~96k sample rates
> o Supports master and slave mode.

Again, this has already been applied.  If you think updates are needed
please send incremental updates.

--GUWDakHTpZ9AxSMt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJStDBHAAoJELSic+t+oim9uB8P/Albsla4jS5J6QmesSjtA9OT
eqGhdaY+enJxp7ImmxJfK2N6vEYHXNqDwswimEVF9XOID5qW7Kqa+3glTip3PqNi
1qgKX//Wn+lhO5mF3W+Ucv2zgsofTS4e+Qe1LMW0ec0PYSLqQQyEE6iy71e/X0mU
6y5ZWlmDTVMNmiKTBY72xbLX9Xj0cyJBq3+MRjKnYwGLqjaPsjCAuDVF0inebgDk
71HeddiR8HaYp11CV2dpGWlrjCx40n/6CCytdktY2Psby7MrIuX8vTpySPoOm2W9
7UHigoGE9vVMuW+fFe11+SKYeFBOi5y4jx16qqoOhpTESS+Gip5kERMXe1pLjd7m
sZGcWURrlltxstJHNAPIagHlUZx+3d/HNAemJzEBNbUDQ5KFhqqqfWKrSV+1ux79
Yv69abF3cWsBjL0TOacYErBUflO6g6Y9bOBF7yEFWtbekfKyT0oLKtKkJG8wlsj2
BpwWmbNNW6cfNvYw/eDxfkymTHKjYshe0vn6zoFSt9yLDRhcr8ex/hTrWYF9LAsW
/umElS+S2kY56HaLCvizshI7xu2sRhghtugm1b6YNVuX/zfP8AJqSxQyO+j5AruM
dDx9MFFJM2hHOmnvKJH3X5OxVUPjcSYTD1JTc0jLqnadTHHjbcfd4q3oJZb4sXgI
bxAIx0s9TplEJ+NrS7rc
=j9Pr
-----END PGP SIGNATURE-----

--GUWDakHTpZ9AxSMt--

--===============4065777973151634231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4065777973151634231==--
