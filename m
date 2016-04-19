From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aix31xx: Add ACPI match for
	Lenovo 100S
Date: Tue, 19 Apr 2016 17:41:07 +0100
Message-ID: <20160419164107.GY3217@sirena.org.uk>
References: <1461081620-23378-1-git-send-email-hadess@hadess.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0396597309042781577=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 42956261AFF
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 18:41:14 +0200 (CEST)
In-Reply-To: <1461081620-23378-1-git-send-email-hadess@hadess.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bastien Nocera <hadess@hadess.net>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0396597309042781577==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uMD30mxrM/iO8yI3"
Content-Disposition: inline


--uMD30mxrM/iO8yI3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 19, 2016 at 06:00:20PM +0200, Bastien Nocera wrote:

> +static const struct acpi_device_id aic31xx_acpi_match[] = {
> +	{ "10TI3100", 0 },

An ACPI identifier that actually bears some resemblance to the name of
the part, will wonders never cease!  :)

--uMD30mxrM/iO8yI3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFl+hAAoJECTWi3JdVIfQl8AH/jRBpKmM0DYDcu32ogsJxeHS
lI+T635X4ZA5zicLv/zpc7mKXgqSpUTICstLt3j5eaLch//c+KfXC8r2Kj3drptA
cjokJElDP2V1wWdH0Gg+5/NUjoCfxjn34N2ONlbPnJTQsZAxeTlNY3nJ91djfJo3
9vIwS/cnhnYBpEDXOof2Q8ZEsqR03MpWhaB8MLcq27rSlMS6/LU29zXw2HKnqCol
08venGLYehx3XUXAVpaCs4URJ2539UakAQOrkXIyAahh6nqSzG+eCvCJL6KzjfFh
Dv3Pwspd5aJYci0b9QmoATFtdPjdtE+6lBTOhknUPYPt+4z9K26bn1TUvIx5kKQ=
=pCjE
-----END PGP SIGNATURE-----

--uMD30mxrM/iO8yI3--

--===============0396597309042781577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0396597309042781577==--
