From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/16] ASoC: Intel: Skylake: Update DMIC
 DAIs and capabilities
Date: Tue, 1 Dec 2015 21:32:51 +0000
Message-ID: <20151201213251.GX1929@sirena.org.uk>
References: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
 <1448703121-5831-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2201516131268173503=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8718126073D
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 22:32:57 +0100 (CET)
In-Reply-To: <1448703121-5831-2-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, "Dharageswari.R" <dharageswari.r@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2201516131268173503==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/X/C7/8fvxU3A5gC"
Content-Disposition: inline


--/X/C7/8fvxU3A5gC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 28, 2015 at 03:01:46PM +0530, Vinod Koul wrote:

>  #define HDA_MONO 1
>  #define HDA_STEREO 2
> +#define HDA_QUAD 4

Are these defines really helping clarify things?

--/X/C7/8fvxU3A5gC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXhICAAoJECTWi3JdVIfQ9YUH/jAxNuQsqAQIumt7N4IE+c66
eUE2fEVK5VHvYm5pHg0FIkud419nOr8EEPnexv1d8Haou6v6gntwhY57grig6JJ2
Fj+v9QBZcXisvrsPgqQg57E6Ej9SWv/6LgsSlbIRcZFeBecgHRq+fyEDiRG2AWsm
r6/+OXJrYglrST1EeqH8KMhSSnIZXisPxY+7LO1skPFZXu51Eh5Ev60Q+m8eSPhJ
UPtGR7uqtRIxTbuws6Ea++pbRH1T/7IQajfJcB97RzjNcf8anZKUhvTY51nxCNNa
jXfWL0n2toLnLLnch7ZIBHfKEN+dLXzynQ6aqnW0HpfNh63OwbUR/zR3Mj3P/TQ=
=3e/v
-----END PGP SIGNATURE-----

--/X/C7/8fvxU3A5gC--

--===============2201516131268173503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2201516131268173503==--
