From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] mfd: mc13xxx: Move SPI erratum workaround into SPI
 I/O function
Date: Thu, 19 Sep 2013 12:41:07 +0100
Message-ID: <20130919114107.GL21013@sirena.org.uk>
References: <1379527587-14567-1-git-send-email-broonie@kernel.org>
 <1379527587-14567-2-git-send-email-broonie@kernel.org>
 <20130919091318.GA22389@lee--X1>
 <20130919095628.GH21013@sirena.org.uk>
 <20130919100434.GB22389@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJmQ7d57n2fskpx3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130919100434.GB22389@lee--X1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Marc Reilly <marc@cpdesign.com.au>, u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org
List-Id: alsa-devel@alsa-project.org


--IJmQ7d57n2fskpx3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2013 at 11:04:34AM +0100, Lee Jones wrote:
> > Please delete irrelevant context from mails, it makes it easier to find
> > the new content that's beenn added.

> I did, off the bottom.

> I only left 22 lines at the top. You're just being pernickety.

I tend to say that when I end up having to page over more than a screen
or so of quote to find relevant stuff, especially if the useful content
is much smaller than the fluff (but really basically whenever it looks
like no trimming was done).

> Either way, it needs changing.

Let's see if someone actually tests the code first though.

--IJmQ7d57n2fskpx3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOuLPAAoJELSic+t+oim9oEoQAIzdU1gyLMZ+CB74kWefTdmH
84/HbT4zjlI/PigBxqfQP8i0IH7mzvX2uXsfNLfU7In3uHaCA8cMjpKsZFVXTaba
7r5DTkBfRGm9MTyFm3ymtKy6ERmxtTE7nRECWUidHWrOxm7bhtw1pLD8NRSqDrEz
n0COXYpAbBJxn7yNIc9W9Dy4NKbH+vsJdCfoQkmwFIb27R+78UES0HG8Hef6T3mH
e+JcEC3t+lmsE0iYXgl/IOha7Cr4JrHxmbelYC8Lm51Uq8Jq2yNid8VSIzngPHxJ
H/7NiuI6eH0Gpc5I9591dYMsYmCnaIM5Zjbajx1YMFHaVkgZSwX/JR/zDL5lvNcH
ouP82t3ls81tX6slV9jfWUBHSsch08Ge4TR/+fWQQsN7OCCgxrDnJlykfwJwFhZ+
FG6cL2inV7fXfcdR2+cWoA4dl7SuxPthgEFVASvML9tqteOKWCN0zCPq9aK4TnUx
0h4WQTNNu6NFGEpAOjby/QVemHEguNDIckxtzgLhdutLbAuoW06LuHlRARoTAHo6
NaD+Cz89uZwZzzi2qr/FmX+oTFIjfshoT1Sg1p/V70dZ0LIMpYoCZ5KEVBk+M4tY
4tI3DwZinv6CKs/HPcMBlsspclBtv/bmD0bpYaD+17PvYu50BMfhgNIAq31WeLUa
up+XQMrhGKnW4fHEpyEQ
=Dgz3
-----END PGP SIGNATURE-----

--IJmQ7d57n2fskpx3--
