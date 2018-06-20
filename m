From: Mark Brown <broonie@kernel.org>
Subject: Re: [v2,
	2/2] ASoC: AMD: Configure channel 1 or channel 0 for capture
Date: Wed, 20 Jun 2018 15:02:57 +0100
Message-ID: <20180620140257.GG6242@sirena.org.uk>
References: <1528354129-5023-1-git-send-email-akshu.agrawal@amd.com>
 <1528354129-5023-2-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6914830552265787333=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 30E8F2673CF
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 16:04:07 +0200 (CEST)
In-Reply-To: <1528354129-5023-2-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, djkurtz@chromium.org, Liam Girdwood <lgirdwood@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org


--===============6914830552265787333==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Content-Disposition: inline


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 07, 2018 at 02:48:44PM +0800, Akshu Agrawal wrote:

> This patch is dependent on ASoC: AMD: Change codec to channel link as per hardware redesign
> https://patchwork.kernel.org/patch/10388099/

Can you please send a patch series with all the pending changes for this
driver?  It's getting really difficult to track which of the patches
you've sent fit together and what's currently pending as there's often
quite a few different AMD patch serieses in flight with interdependencies.

--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsqXpAACgkQJNaLcl1U
h9DdFQf+IolwLAVOV0PbeU17Tz5AkSGTqgLhSP9bwS0etfjcVcQ/J7yls1wLOvIy
w9OcpEAlGa61C43O2TXRAgpkD/j9/c2pW1BtZTca3nMu4yPKF5sDavVSy+iiDVh0
Y6IMGVsjgZOgJxlYVdr+5tMvTbKTiJic7VAkNyzFFSZ1Sz0gB2sICijJQtpc73ZN
wbGoVyRszvpayvO3HKm++zOe9pI3MWzdlCb/2wDMc2/+QuHoWLNfoAE2pIBmrhCH
QuG7rRFDS0iISTaljq1QFx2Av0NnkmUEaI/S1I49apckTIZzJGUdN5vrQYhOH7H5
F9v91jU9/MUTj6J5WM864sz+rugSOg==
=BTiA
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--

--===============6914830552265787333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6914830552265787333==--
