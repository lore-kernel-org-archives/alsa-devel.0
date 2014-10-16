From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: intel: turn off COMPILE_TEST for
	medfield
Date: Thu, 16 Oct 2014 11:02:35 +0200
Message-ID: <20141016090235.GA6678@sirena.org.uk>
References: <1413447869-23494-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7711415825117014185=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DBD92614EE
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 11:02:52 +0200 (CEST)
In-Reply-To: <1413447869-23494-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7711415825117014185==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2014 at 01:54:29PM +0530, Vinod Koul wrote:
> Since medfield machine uses SCU_IPC which is not availble for all archs, so
> compile test fails on these

Applied, thanks.

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUP4mrAAoJECTWi3JdVIfQTQsH/2cbVjZiqpfuqAlosw77EkXO
nC0gvvDaC6H6P3dKr4xjgwnSRZZM/MnFXNXZk3Yi7GjH8erznPxLvY7vBe5ffZbv
1URrgHeFFiv70VX6w13ztL96BBE2ynByCs0H8ID/ICbCYpb9Kj3RWZDCzP5t7DlO
NH58MPZ+kOeukZnJAtlqNiCyhBIPjtQAwakW27Jb3jW95cR4oqx+Z+ck38DqBk5D
MPILIElfWJfDIxbZYE0VjP4NAdsJ3cwR3VrZ6HDvrC1Jnw8W1uVKxafpROHTxpVF
JQAAAuufrtoZ1lrpqshlhelJuw7fvtNohBg3jMKuFmczPIOgU3/qQRWk1tJS82Q=
=5dQ4
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

--===============7711415825117014185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7711415825117014185==--
