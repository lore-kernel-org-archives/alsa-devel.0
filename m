From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 4/4] ASoC: amd: enabling bt i2s config
	after acp reset
Date: Tue, 17 Apr 2018 17:10:25 +0100
Message-ID: <20180417161025.GI8973@sirena.org.uk>
References: <1523941201-15665-5-git-send-email-Vijendar.Mukunda@amd.com>
 <1523980325-4242-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4498658496216761735=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 426A02675DE
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 18:11:03 +0200 (CEST)
In-Reply-To: <1523980325-4242-1-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Jason Clinton <jclinton@chromium.org>, Alex Deucher <alexander.deucher@amd.com>, Dylan Reid <dgreid@chromium.org>, Akshu Agrawal <akshu.agrawal@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org


--===============4498658496216761735==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Content-Disposition: inline


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 17, 2018 at 09:21:45PM +0530, Vijendar Mukunda wrote:
> On ST/CZ based platforms, for specific platform bt uart
> mux to be defined for bt i2s.

Please don't send isolated patches numbered like they're in a series,
the numbering is only there so people know what order a series should be
handled in - outside of a series they mean nothing so just number within
what you're posting.

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrWHHEACgkQJNaLcl1U
h9Cq+Af/TaC+eA4q7acZzjEJEHNo/NV+rJ7jkXgyShPLc5gQPQwbO+KEMhKGQ+gy
x/yT0/oh70jSxfpfPDktVrNqBTg27d2M13dxp2GhGjg41hTqzWvLWlGuaZhfCXbx
5IWtmJe9883L8wclEdgiTaN3xFUZQyQAj1tft26t3xn4yBR4TNdB8M8kJq527bZV
NKESwZfyjV/SV8hQju2e1pDeXYjtdDxVpsHpYVZ34Bn7BGHG/QsFfq4wmp2+Ob+p
A7bvIiGRXCYZkZD5aEnBuH9fLIen4C8qVGy7YbNjeWlGSsuHny2xwrkZBknRjni0
CL81mSijuXwj00PxNf/QYBtKJ/K6Cw==
=TMm9
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--

--===============4498658496216761735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4498658496216761735==--
