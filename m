From: Mark Brown <broonie@kernel.org>
Subject: Re: Correct git tree for ALSA development
Date: Thu, 2 May 2019 10:35:56 +0900
Message-ID: <20190502013556.GO14916@sirena.org.uk>
References: <20190429202918.GA35915@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3497531339079597765=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C2F0F8065C
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 03:36:02 +0200 (CEST)
In-Reply-To: <20190429202918.GA35915@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ross Zwisler <zwisler@google.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3497531339079597765==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bAr+fMtvBxbbbkvl"
Content-Disposition: inline


--bAr+fMtvBxbbbkvl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2019 at 02:29:18PM -0600, Ross Zwisler wrote:

> it seems like current development/maintenance actually happens somewhere else,
> possibly on Mark Brown's kernel.org tree?

My tree and Takashi's tree for our work.

> If so, should we update those stale MAINTAINERS entries?

You need to check with the relevant submaintainers, they may well still
be using the relevant trees for their specific areas.  If something is
listed separately in MAINTAINERS then there's a submaintainer who may be
maintaining their own stuff.

--bAr+fMtvBxbbbkvl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzKSXwACgkQJNaLcl1U
h9BovAf/bwLtqcAVsqmVhs5NN4rhvNHpCrOqS7ZUc783n8zHxerZNtNBSkjaBnaD
r2VsGhfPc5PLG88IEoniNmJabe2TlakiZSArnFqqUFLw15zkdCxXSWNl8wOZ4cdv
8YizlxD7x7t4/OWzsRDHj3F/9e94lNQ5453b9hwYW32hYEjxJV5QT/4+HywD41bT
rn9yzeQ0aQjwe+L9px/CpVH8fJJsE/ePPHDaPx0eW56izfEPKBtb+Uy5Zh6KSOEb
W87O1AOtwu1YT4WHfJom0MT161/eDBKdz5W5LFh5mj/0dqr7XjTf2faw1dNrTzp/
syJYkKMcvmyTIiao1c5boK+8HiYA0A==
=GEWW
-----END PGP SIGNATURE-----

--bAr+fMtvBxbbbkvl--

--===============3497531339079597765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3497531339079597765==--
