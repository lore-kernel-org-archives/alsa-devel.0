From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: Intel: Export Baytrail PCM
 streams under one DAI
Date: Wed, 14 May 2014 16:57:43 +0100
Message-ID: <20140514155743.GI12304@sirena.org.uk>
References: <1400077254-31465-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0505831149831722770=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A422726089A
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 17:57:59 +0200 (CEST)
In-Reply-To: <1400077254-31465-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0505831149831722770==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oFPe7kv08XVM7cpf"
Content-Disposition: inline


--oFPe7kv08XVM7cpf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 14, 2014 at 05:20:52PM +0300, Jarkko Nikula wrote:
> It wasn't necessary to export Baytrail SST PCM streams under separate
> DAI links and complicated needlessly basic ALSA command usage (for
> instance arecord).

Applied both, thanks.

--oFPe7kv08XVM7cpf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTc5JzAAoJELSic+t+oim9yToP/2BjTmQkaFHLdflogDi1d37+
V8NgWCKNf8UaRv/M+JpHqQDw0PZojZygwuvPqIIqhhjSC+Sc/KJ3JygmzurKo40j
luqsZ3qFnKj0sbvZufZXf6FXXg32o+CARPq/xORH614VErO4veNIsXICqWc4DaP6
cix/E6uXKIsLIsoizUOzcdL5ry19/WpBHe4Rs0gqqmbuonwnW3vbpIP4z3O3rJro
jBZ34LGTygUn225PdACWIt+RuOnxtZcp86YR8xf0AGxIyVw0v0Laha7hDqXc/toQ
j17POo7dEVtR0N2ljzXMcFQ1jhLaQcpzO31nK4kZhTfrxDdI7vqx+qyHUAFjDlHy
GVXUtRKjmnMWkkeIz8E1GAKx7Fg0zXE9kcZi/Lmqi5QxPoezoENhd9nBclgHz+jQ
Qt9j6a/a32LjLtNQApAO4ms7JY8H2AkdKLDCy6Bk2qciJBESFRalj+gq2cK9BVeQ
liUeVcb+XGycYe+DCMcusf6oz+VvVai4P96WduE8R6VNJPU/mS0enFTD/oZKuw+9
uSm9X+sNaOZy/GUaDCMFnhL3Pfo/P8oeBoVnYNb6/0Ts1mI8sTFXuJ8awovOpmuX
We/Edp1NBuPk9NFHctQKphzYy5hYzHqMe+vZCOHeRwFhRNxy1aFHl/Telvbd2Oe9
C3GFEBcX8PXkAOWiuf/+
=IwKZ
-----END PGP SIGNATURE-----

--oFPe7kv08XVM7cpf--

--===============0505831149831722770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0505831149831722770==--
