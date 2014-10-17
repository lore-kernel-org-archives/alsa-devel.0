From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 0/7] ASoC: Intel: sst - add the
	merrifield IPC driver
Date: Fri, 17 Oct 2014 17:26:17 +0530
Message-ID: <20141017115617.GT1638@intel.com>
References: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
 <20141017121539.GI1820@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2133962298934407501=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 864592651EB
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 14:32:19 +0200 (CEST)
In-Reply-To: <20141017121539.GI1820@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2133962298934407501==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kAOhhqH5290wydqT"
Content-Disposition: inline


--kAOhhqH5290wydqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2014 at 02:15:39PM +0200, Mark Brown wrote:
> On Thu, Oct 16, 2014 at 08:00:12PM +0530, Vinod Koul wrote:
>=20
> > This path series adds the Merrifield IPC driver which is used to load a=
nd
> > manage the DSP along with sending and receiving IPCs for PCM and compre=
ssed
> > audio.
>=20
> I had some concerns that I replied to the individual patches with but
> they're all pretty minor so I've applied everything - please send
> followup patches dealing with these things.
Thanks a bunch,

Sure I will follow up with you on those. Time to catch the plane now :)

--=20
~Vinod

--kAOhhqH5290wydqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUQQPhAAoJEHwUBw8lI4NHZJwP/0iq2k/b1IMz8KpUESPLPZ+V
V4H8/4r+zH0HqXhfJpER6QvpGeIs12vMZMOdXGKA09WL8woQkSlPiY5dbMceD62a
Qq6uwOtaPIjp//xvglbX+ci7FVG/2yobw7bt+m9XqtNnGKjduFYx3gEPOl22OCM8
2OUAKhfRwniKYN0GNbPgbHBaMvAdiVW9PCNni3kS5rwEqOLnDiRIJQwMT/h4HwvR
LsCYv1HHwOpYobBM11RomxA3gA7eYV44C1xv6Gta1+31hgT3Jn4owJP1pI2pWvwg
2oAODG0e+KpegBFCF7cZ8s5DxalB53EkZXkvX3MBVT5zKFm5DhR0Atf2tb0ocbMl
iKyHJE1qesJx9ioV31JH5w5DJZIOlsted7KyOMTXLjbFVwejIsl09dDlWoleGQqT
Qy8WjFqOgVJXy2Ax5LIFw3iSxTwE6mYMZ1AVtyPTXq0Tqz+V6VMMxiFVsS9Wsw5n
UuZS1pqWE7nOFjlYHOfFXkaZbzItbhA0dMNp7kxaYeK2bWey7+a+cLq5xD6CqN3j
OnDxRVeec2tLanH2QpQMiqKt4H+AqjsAj3QUKFruaez2DRvz+NvJB5wNE2GR3P34
HL6cY+1taH77ticTC1uIf1AfVEN9TvMlYqhMUEcMg0SYkLftEVTWxg+ZLrHgSDKA
IX0hOZ68IX3uIEw2/jed
=lu2S
-----END PGP SIGNATURE-----

--kAOhhqH5290wydqT--

--===============2133962298934407501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2133962298934407501==--
