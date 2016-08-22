From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sunxi: depend on ARCH_SUNXI
Date: Mon, 22 Aug 2016 18:41:38 +0100
Message-ID: <20160822174138.GU22076@sirena.org.uk>
References: <20160822121242.18827-1-pbrobinson@gmail.com>
 <2008659.grltYsYuN0@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2194322313104418568=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2008659.grltYsYuN0@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, wens@csie.org, Peter Robinson <pbrobinson@gmail.com>, maxime.ripard@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2194322313104418568==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QOa9dl9wYIBIim/b"
Content-Disposition: inline


--QOa9dl9wYIBIim/b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 22, 2016 at 04:49:11PM +0200, Arnd Bergmann wrote:

> Makes sense, though I think it's nicer to add the dependency to the entire
> menu, so we hide that as well, and don't have to add the line to future
> entries:

Yes, that seems better.

--QOa9dl9wYIBIim/b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXuzlSAAoJECTWi3JdVIfQyHoH/0AikM35eAaGKyzkOZrz6gI7
bGH+LmO2gP4VGeX8FEsRPUPkpk93bQz/nQGapfoQCbhZc9raiUqkyhXYLjSc+dLb
97Yh5vFAjDQXqS4KNGckzxNhY42vJWIYBy9Pb4M5ocPVo5zLIT2aimPeiBEvV40h
fVtf/GXNdTxt9tqgvdceDVP5grGOM7HRI9ewltHWIA49YcYj1B9MURY3dy2fxMvt
SPxVfWogEy2kkS9koNraOe21/1iepU1Cuwtm6ITIkL+zgTcj92z60s8Z6XSLW2Y5
UbX++O+RDYkW7kHgNcvOSshrdd7PPt3wik/0/CGyzqJkJqAq1wc63taOsoDFmXU=
=lTcz
-----END PGP SIGNATURE-----

--QOa9dl9wYIBIim/b--


--===============2194322313104418568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2194322313104418568==--
