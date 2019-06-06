From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 000/146] ASoC: modern dai_link style
 support
Date: Thu, 6 Jun 2019 15:51:15 +0100
Message-ID: <20190606145115.GC2456@sirena.org.uk>
References: <87h893mkvi.wl-kuninori.morimoto.gx@renesas.com>
 <20190606105632.GY2456@sirena.org.uk>
 <3b43fab0-b476-4623-1bdc-9d750eaae83d@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6590388293274977540=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 091D0F80768
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 16:51:23 +0200 (CEST)
In-Reply-To: <3b43fab0-b476-4623-1bdc-9d750eaae83d@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============6590388293274977540==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tmTZLG6vUqJL4TmU"
Content-Disposition: inline


--tmTZLG6vUqJL4TmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2019 at 09:08:56AM -0500, Pierre-Louis Bossart wrote:
> On 6/6/19 5:56 AM, Mark Brown wrote:

> > Are you sure those should be signoffs and not acks or reviewed-bys?

> I did provide 10 corrections with a Signed-off tag directly to Morimoto-san,
> but I am fine with a change to Reviewed-by if it's deemed more appropriate.

Ah, it's the squashed commits - that makes sense!  No problem then.

--tmTZLG6vUqJL4TmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz5KGAACgkQJNaLcl1U
h9Cy6gf/V7a41eNNZxgJXvu9Kp17qBM1gR4l6Hd+H59iW2s2AjEG5MxwA8wtpENR
CMFSaJsp0B99boFM8cDptUrOU2l8HYUnCsJHAsUjxv1pXoBZDnKaJzbp/LnJQC0+
wKAAzGLnPf/TkU5o2aPk+x9tYKxe60tLVt4v5T5bCw7ziA1CSItvEhg/HgZJm7wI
Vl9PfugdfcwP8jtw1M6v3PUke5tSBOb2VTHepCbJBNlQVhr0kVswfV3CoLvojAY5
XIbv1hoeSKRr259Uy0seWiPdeLfuL+uJpCcQ6fR/rTK3G/7H+iUH6Hcl4yRwikxP
ZlgaPJnIcPfgztlMT7aFMRLMGUb4Nw==
=Xfg9
-----END PGP SIGNATURE-----

--tmTZLG6vUqJL4TmU--

--===============6590388293274977540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6590388293274977540==--
