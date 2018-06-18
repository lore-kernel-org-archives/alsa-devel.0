From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/1] ASoC: stm32: sai: add iec958
	controls support
Date: Mon, 18 Jun 2018 12:15:36 +0100
Message-ID: <20180618111536.GB6928@sirena.org.uk>
References: <1528730039-15757-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6091987702409597780=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B81152673C7
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 13:15:51 +0200 (CEST)
In-Reply-To: <1528730039-15757-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olivier Moysan <olivier.moysan@st.com>
Cc: benjamin.gaignard@st.com, alsa-devel@alsa-project.org, alexandre.torgue@st.com, linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, mcoquelin.stm32@gmail.com, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org


--===============6091987702409597780==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 05:13:58PM +0200, Olivier Moysan wrote:
> Changes v2:
> - Remove iec958 helpers and implement iec958 controls in sai driver=20
>=20
> Olivier Moysan (1):
>   ASoC: stm32: sai: add iec958 controls support

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsnlFcACgkQJNaLcl1U
h9COmgf+NZeQhx8mEwgNi61ycoyHKgoTRSLM/VDnAu3vrL186K5ShnXF6INDoZVv
CbgkTlKnRC354vn+fNMWR0bAuwRznhyDNObMlprS6RRk2O2nW8Z7f0j2LTZ5pJ1M
IAIh4yhBFIMYSsYO156zJL0LNlQyw4CPepH28RA8eJDhFcE4SLl10O5yCyTnkvmi
MW/C+J3KrSk2gjGS2JuGQ7aB2rzZuMp8JcqpXgkIx94RjwijANhQtI8MlnEaenV2
HmjkxHbP8bcyKVuOqLvQvIUEImv0+L3gPOv6Vu5TkytIOIDPBcI3V55RXyQoXdT7
tTxtAC+EO+4ovA2r/3MhUC0uEV113Q==
=2A+u
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--

--===============6091987702409597780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6091987702409597780==--
