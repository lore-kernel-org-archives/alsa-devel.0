From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: compress - add support for
	metadata apis
Date: Mon, 18 Feb 2013 13:19:28 +0000
Message-ID: <20130218131928.GB30157@opensource.wolfsonmicro.com>
References: <1361183381-30010-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3810249280585923553=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4CF67264FEB
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 14:19:30 +0100 (CET)
In-Reply-To: <1361183381-30010-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3810249280585923553==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 18, 2013 at 03:59:40PM +0530, Vinod Koul wrote:

> Mark, Takashi:
> How do you guys wnat to take this one, Ideally this should go to mark's tree but
> the dependent apis are in takashi's tree, either way is fine with me :)

Since we're expecting the merge window to open today or something
probably the easiest thing is for me to apply it after -rc1?

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRIipZAAoJELSic+t+oim9bs8P/iVtUhMEN1VXWdd2uIdDhcLK
6B0Hzbn9Ksfcfl/YIKpDtundR3azk6w02Ygxiqb9Y1KeEivHOHo5p9tdv+L+hFCU
taXvZtzSJgNcHdNdvhqo3oEKtZE62qZraSG0/Vl0K1qgbTELs4d5xLer7J6pIdgY
vW1BcyQB7P4jdEqLQAp6cA3FnHnrY6GRo4QgoosUuoXAHn6slj/036DiIeP1csbK
RXGiHnBfnp5OxTfE68ZCpsMEOdiNtaCKh/J24pQJ3/iD1y21BeSWSA6T/UEKXPkD
oZx8cjQJ/0OmfcFnppHSI6OlMutOqm3OSLt13cKVwMXXTrx70U65ScXbJG2/UImx
NG8cIl/hNIipfGBaDbhGGScJwNGr8xNjaDkRWO5k/ywJwOSXChZ2d2YKlodWePy5
Mbhge0ZH2vcEPxQ24YZBFG5v0e/v6Bt37MNgFNh2ayXybbGr60Ngh2x+WdBOdS6p
drWbuQN2jM8Q+59cjAoU3jtL5hwhMY/WPl0WZrQ1vYEUc4MrWRDyS7XTaqLvhObn
fzoDYPvzWU7jSgVwlAZSCoJ9QAttcZqvmQxi6WFkiLCregpB3iuIUWWInr9V/BwR
CINAdw7yPyHTY+CrYLUHuABcUpreizlKA8zdPe1h2i0K4o+Gw0CtAookUzSAFX8N
kJhXSMtT9/WXaYJPhI4e
=f815
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--

--===============3810249280585923553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3810249280585923553==--
