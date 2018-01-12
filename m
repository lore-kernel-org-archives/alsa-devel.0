From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: hdac_hdmi: Ensuring proper setting
 of output widget power state" to the asoc tree
Date: Fri, 12 Jan 2018 21:20:12 +0000
Message-ID: <20180112212012.GI21458@sirena.org.uk>
References: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
 <E1ea6ZJ-0003BS-KB@debutante>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5238037144052089115=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 90016266B67
 for <alsa-devel@alsa-project.org>; Fri, 12 Jan 2018 22:20:21 +0100 (CET)
In-Reply-To: <E1ea6ZJ-0003BS-KB@debutante>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Abhijeet Kumar <abhijeet.kumar@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Guneshwor Singh <guneshwor.o.singh@intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jeeja KP <jeeja.kp@intel.com>, Sandeep Tayal <sandeepx.tayal@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5238037144052089115==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mFHiwr52TKrxpkjc"
Content-Disposition: inline


--mFHiwr52TKrxpkjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2018 at 09:08:53PM +0000, Mark Brown wrote:
> The patch
>=20
>    ASoC: hdac_hdmi: Ensuring proper setting of output widget power state
>=20
> has been applied to the asoc tree at
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git=20

I've dropped this because it caused a conflict with the topic/hdac-hdmi
branch - can you please check what's going on there?  I merged that into
the topic/intel branch so probably just a rebase is needed.

--mFHiwr52TKrxpkjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpZJosACgkQJNaLcl1U
h9Cq7wf7BSmsU7juz3YbouUiJJjOjXAfa/pfSddkaJe7rqVoYAf3yVAOgWBpYybq
eWTjFFVpTBrwB/nrf6XDEZ7YUovkhz0orNT5LaACpyjJooRwbsgzXewvfUwzh9E3
818Gcd959Km7+2GCGPDd8wXRxlBEDp+TuGuK0lvYKk/kcOREReyXBkmr/5XLLOGr
EQFOw7Q5JBpfHQi5GcSw+3vwFJx6TNQALwOQI+9RSStWjt0XdLXM8Nm1kl8pyr+/
GPEaQlKCBy47vPhX3NQUbmLEmZg0vryj8keWzcCDqa8wbS8rRyQzWwj8jJO2iYjn
KtqFFsZ2ztvqVjB0BX2xrgZbSfuxiQ==
=EcyD
-----END PGP SIGNATURE-----

--mFHiwr52TKrxpkjc--

--===============5238037144052089115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5238037144052089115==--
