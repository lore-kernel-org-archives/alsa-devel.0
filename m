From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/8] ASoC: sun4i-i2s: Update binding documentation to
 include A31
Date: Tue, 31 Jan 2017 21:17:02 +0000
Message-ID: <20170131211702.taxbrgxwo7b4daej@sirena.org.uk>
References: <20170131100552.27949-1-mylene.josserand@free-electrons.com>
 <20170131100552.27949-2-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6504539648710768471=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170131100552.27949-2-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz, wens@csie.org, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, maxime.ripard@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6504539648710768471==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fqu4r7deq3qtaryy"
Content-Disposition: inline


--fqu4r7deq3qtaryy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2017 at 11:05:45AM +0100, Myl=E8ne Josserand wrote:
> Add a new compatible for sun4i-i2s driver to handle some
> SoCs that have a reset line that must be asserted/deasserted.

This doesn't apply against current code, please check and resend.

--fqu4r7deq3qtaryy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliQ/s4ACgkQJNaLcl1U
h9Deewf+Nv/3/d0Zf/+w6HSgaUiOeX/UKVLJxlKUfcWeI6QshhwrL6tv4B4ZhMIS
cueluXSdgenHes0P0r7Axb++OuSZgj24sVJ2CA1XzhikQ80+IOWDWEeDm/yuDkd3
TvZYW/syTS+S1r9grv8pW6zskuvtgHRmuEWwT/YhQtzU2G8o4cTqvBR4mU6GqbnJ
QCE0oTuPOzNgD843++0v4VHHcDfApsLDiDXjywnIKeR9jRrryCRcsdzDTu+N2YDS
XgjjfwWwurwT08GPmaaikY92IeeMgP4WY0ZR2uatBRy8JBy3xft5xDCNtAa6dt3J
A0uT/01RkoW/hy+2D2Q7XZzMLQMAzA==
=KM99
-----END PGP SIGNATURE-----

--fqu4r7deq3qtaryy--


--===============6504539648710768471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6504539648710768471==--
