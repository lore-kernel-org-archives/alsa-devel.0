From: Mark Brown <broonie@kernel.org>
Subject: Re: Audio Miniconference 2013 schedule - Edinburgh
 21st October
Date: Fri, 4 Oct 2013 23:18:14 +0100
Message-ID: <20131004221814.GW27287@sirena.org.uk>
References: <20131003181754.GE27287@sirena.org.uk>
 <524F34FD.8090404@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6305168138461808339=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D996261643
 for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2013 00:18:24 +0200 (CEST)
In-Reply-To: <524F34FD.8090404@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Colin Guthrie <colin@guthr.ie>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Arun Raghavan <arun.raghavan@collabora.co.uk>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>, Tanu Kaskinen <tanuk@iki.fi>, David Henningsson <david.henningsson@canonical.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6305168138461808339==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WpBsPuQsCdPBgAv4"
Content-Disposition: inline


--WpBsPuQsCdPBgAv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 04, 2013 at 04:37:01PM -0500, Pierre-Louis Bossart wrote:

> >  - Effects offload to DSPs with dynamically instantiatable algorithms,
> >    and general dynamic DSP firmware handling.

> I can try and prepare an overview about what we've started to look
> at for effect offload. The one thing that's missing from the agenda

Thanks, that'd be great.

> is that DSP offload and dynamic firmware handling do require control
> on audio policy (high level arbitration between use cases), audio
> routing (some paths may not be available at all times) and resource
> management (memory/MCPS/etc). We not be able to solve this in a
> generic manner but having hooks to detect/notify a DSP resource is
> or is not available might be a good thing.

Yes, all that stuff needs covering - I think I was trying to include
that with "dynamic DSP firmware handling" but it really isn't at all
clear.

--WpBsPuQsCdPBgAv4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSTz6iAAoJELSic+t+oim9ocsQAIs9lP9/JwCvxb87/Gz8WbvB
1PoZDo9wlHCgPlfSTTc7qCZ7W06m+TkKVtoiCjLXXjinbrrvc5NvS3Nuvx3zpNcJ
58qzmKbEjuBYirrDA6urbx+soIzcpNrfw4hDclRBO6by6xEEV9ObOr4iwW3BM7cl
hLQ3NtuT3Zkc69WvSbsvf9ACJ7aIwT5fwIGAgbw+OfBF1GY9LATVln6SjhCtC9bT
+vC5A+6GY1tlffJmiFLqkTJqkvBHS9m76ZlyZPKrvvSy8amUnTsxosEMO1k9BYIL
8C3gztIlzQMOgGHt74MFcQoNRR5AUVO3VzbI2zyYpLtxv75atLGnOwkEh5IvKqay
3+oCVQy5dzQ6hfdd9vnJRpbZYT/J8otnl3VTM6GN3bk3nVTqmeRifMsj8zj+26T+
R9hTrQsy+wmgCIzQw0GuxYV5UdxowkbZu9xwKsKULm/B6EfGuy7UEIyw0wLkM6oD
uESQccfFa2RqPMWzvHBHLYoihtYtJMiZU2fnGpTs7s6/J0sqmXMAY04cSjdpiVKc
KaUiqcWtKwDMzOlFexQbuBbvZOC7eKx58FBxnyj6WXJ+wScpYmSxdj+oQvSkjT1T
xWA39gkL5QzmBwntC2gJrzPafH7lWAmmZhPfhcPgz3kjYzr1Nal11wQY9kZKabYj
jNMe57zi/5A+MvU4A+xd
=0Bxd
-----END PGP SIGNATURE-----

--WpBsPuQsCdPBgAv4--

--===============6305168138461808339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6305168138461808339==--
