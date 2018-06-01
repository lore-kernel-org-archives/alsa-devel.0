From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Fri, 1 Jun 2018 18:11:57 +0100
Message-ID: <20180601171157.GD8677@sirena.org.uk>
References: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
 <20180601102506.GB8677@sirena.org.uk>
 <0015aace-fe32-9707-d3c9-0dea6f5fc48c@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3099315677742437438=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B876267772
 for <alsa-devel@alsa-project.org>; Fri,  1 Jun 2018 19:12:22 +0200 (CEST)
In-Reply-To: <0015aace-fe32-9707-d3c9-0dea6f5fc48c@roeck-us.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Chintan Patel <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============3099315677742437438==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 01, 2018 at 06:17:05AM -0700, Guenter Roeck wrote:

> Other than that, there was a question if this is a Linux issue or
> a Chromebook issue (it appears that only Chromebooks shipped with
> v4 configuration files). I took that as rhetorical since upstream
> kernels (at least v4.4 and v4.5) support topology v4 configuration
> files, and it should not matter which products shipped using those.

Yes, that's definitely completely irrelevant here - one of the great
things about Chromebooks is their upstream support and this code was
definitely no exception!

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsRfl0ACgkQJNaLcl1U
h9AcgAf+M5/KOrs2V584NuGmUEoErJ27oGBQabujIUbxMFFHIVMLimpDmH4qlTW1
Iu5i/H+E7r2yr0JL/DqfO61PGsCMaBT1ZYHOfD2xPZTUp6x4lDv9cP8Sun0jkoDE
WJx7E8NyY0lF+MsJmaKc0cq2tSjOyqBKS16P7VKFBB+qtwgbXfSwSFejG/t3ZHwk
lqjJYVf3bYR2KDBCdswCEsboGrxLBw9MK5/Pmm7vezPjD/I+UGXKcH+Hag1Ryv6s
4o+BTYJFd4WTvWqGO04r0ByUps+enn5mdPbvyrnGAll1yD3febZI7P6Sz9lFbiTx
E9Op5K3sKMFkB+cD+omM/MiPUs6KLw==
=+Ejj
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--

--===============3099315677742437438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3099315677742437438==--
