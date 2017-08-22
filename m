From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 1/9] ASoC: rockchip: Remove obsolete dmic-delay
Date: Tue, 22 Aug 2017 11:32:41 +0100
Message-ID: <20170822103241.wjiycavsro7abknj@sirena.org.uk>
References: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
 <20170822075729.8438-2-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sfd6kwa5gv2uuqiq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170822075729.8438-2-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de, briannorris@chromium.org, mengdong.lin@linux.intel.com, mka@chromium.org, lars@metafoo.de, dianders@chromium.org, Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--sfd6kwa5gv2uuqiq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 22, 2017 at 03:57:20PM +0800, Jeffy Chen wrote:
> This property is no longer used.

I would still rather keep the existing property documented (the binding
does need to be fixed) than remove it.  It's better practice and it's
not costing a huge amount.

--sfd6kwa5gv2uuqiq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmcCEkACgkQJNaLcl1U
h9AnCwgAg1r83SQpPvfPsqZ3641YmOmeiYzy/h52Rff9VJzqgOY3zeaBFWty9mdg
1IlvwS481SZcnu129HUQElZ/DImjRDyBKGuphOipcbYw3yX3Rn1vsnrxjefgptVh
H64G3FFu3OzL4I/tXwAl29IR1EimbZ0FHBot9TkUgTkRGm0aWNw96msPDYphWm5E
y61YlbgNsZNNIqHh4dIHzJY5uBvf96vFELZ5nxamXLVFjYYJ3Sc4+JxWdY9uM5mk
HbpX5Ycn39p9ciC/Nue/V1Dh8cGHuD+FiMOU6cMfCtIqtlNFca876PhEBRlRK96G
HVSWycfRAI4UfawBgaUmF3ph2qx2UA==
=10xG
-----END PGP SIGNATURE-----

--sfd6kwa5gv2uuqiq--
