From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/10] ASoC: Intel: Skylake: Add D0iX IPCs
Date: Fri, 28 Oct 2016 19:06:28 +0100
Message-ID: <20161028180628.2wylswqs7rddvcds@sirena.org.uk>
References: <1474868137-29712-1-git-send-email-vinod.koul@intel.com>
 <1474868137-29712-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4397412651911681245=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A0235265D93
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2016 20:06:46 +0200 (CEST)
In-Reply-To: <1474868137-29712-4-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jayachandran B <jayachandran.b@intel.com>, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4397412651911681245==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="24hikfu7l6sm2mmz"
Content-Disposition: inline


--24hikfu7l6sm2mmz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 26, 2016 at 11:05:30AM +0530, Vinod Koul wrote:

> To set D0iX, driver needs to tell the DSP to go into D0iX mode by
> sending "Set D0iX IPC". Add support for that IPC.

What is "D0iX"?

--24hikfu7l6sm2mmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYE5OjAAoJECTWi3JdVIfQhEMH/0FSGjervktIej5ZR6q+dmJK
O5SSikJt/KU8VC6IwfwKbqGwCxQN0WnB4ghdZVnsQXjrqBNMOowJUiszg6vtmhhE
bdVGn4ZVWKoKvytiF2qeNNuN4xJEBNAoOaf8OABqFw3n+PtqqGWpcVccrYlN/hym
hh4m4gQcfNTUjXujo2aTOyEkP/9ChGLRLV3Tl//SnaNrU73/fFF6C483F8LuO4+a
lFpoHBV0RP7c5jEAehMWLRiRJqhGodamtZoU0s7ROUzCl0ZRiPutQvqEdeQkK7qn
O1lq63HV3nO2t1Ph7nyLnfMPR0qAw6AJk+ceYKg7NIwvLO6ArjK+IvaWJwaGJOY=
=D9Cg
-----END PGP SIGNATURE-----

--24hikfu7l6sm2mmz--

--===============4397412651911681245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4397412651911681245==--
