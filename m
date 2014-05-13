From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Intel: Fix Baytrail SST DSP
	firmware loading
Date: Tue, 13 May 2014 11:53:52 +0100
Message-ID: <20140513105352.GG12304@sirena.org.uk>
References: <1399643264-7669-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20140512220945.GA12304@sirena.org.uk>
 <5371C820.6010207@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2197871132358226652=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E3E5D26517F
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 12:54:14 +0200 (CEST)
In-Reply-To: <5371C820.6010207@linux.intel.com>
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


--===============2197871132358226652==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A0stI2AzS69m3AnR"
Content-Disposition: inline


--A0stI2AzS69m3AnR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 13, 2014 at 10:22:08AM +0300, Jarkko Nikula wrote:

> In case you are thinking to queue Liam's 10df350977b1 as a fix Is it ok if I
> resend this on top of it and handle conflict when merging
> origin/topic/intel?

Yes, it's on my fix/intel branch - please send a fix based off that.

--A0stI2AzS69m3AnR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcfm9AAoJELSic+t+oim9/E0P/RsAVfVTxoBgjenhWigvmacn
inEKYXLbzilStQ+OG8iQa9eN51T14BKD+9ltfw7AgIBbFjE5fPO9U/Br3o6htTn3
vCUjwzQtAY42OSV0trkquwJeA/adHgJJEr8NTx2LoyTmfEYGo7XgZnxMEYBhW8iu
BLqgEOt4ofUjsJ4m0lmdj81PRR9mWXAC9ZHOENkfRv07HuJJuFI53yV4P41lV2aO
duxVbde1rsi/ua153Z1Ocy/aBoYYhYkyDuiAgE/pV84f5SUi+8hWduHIRfc/ZKKa
m+wZjjeCpz51TciRPyFl+aRi4xVJi+iWTW4zEpDIdHY60VcrBFlFQWAqRgR/Or6b
7Plbk4M6kR63aZmPh5rKzyVeh+uuAqPxMRB+E9vsPcAW5WLcokkk/yyI4dWd8EPk
0ALqzdw6mJ+TBr2tgezF7aLf1mg+XpkoE7GDnhP8xXpNVDzmoQ5sETuV4cg2ODyp
b1Qd36AfiAOYi2HiQZSovK84x5cCkyqce1QfgbFSsDBZJTW6dXEcL9ywqn3ClD28
8zbbXWtZ2Gt60LltNAsIMAEjLXuH+5O7QeKiFs7VX6wsGCXYblizMQIDeqIiulNf
nFiwxEmevLv2g0Tp429e6fg2v+poWuLTMW8+FxvN/lGNJnhyPYTRUfDwV/LciPEA
4CH/ljJVBF+qHIkg40g4
=UJFp
-----END PGP SIGNATURE-----

--A0stI2AzS69m3AnR--

--===============2197871132358226652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2197871132358226652==--
