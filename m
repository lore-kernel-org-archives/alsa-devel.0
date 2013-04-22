From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] Add capture support to compress API
Date: Mon, 22 Apr 2013 10:53:35 +0100
Message-ID: <20130422095335.GA30351@opensource.wolfsonmicro.com>
References: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
 <s5h61zi7i4o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6528622610280667968=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 51A6826030E
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2013 11:53:38 +0200 (CEST)
In-Reply-To: <s5h61zi7i4o.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, vinod.koul@intel.com, pierre-louis.bossart@linux.intel.com, ckeepax@opensource.wolfsonmicro.com, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============6528622610280667968==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 19, 2013 at 03:41:11PM +0200, Takashi Iwai wrote:

> If we really merge it, don't you mind me merging soc-compress patch in
> my tree (directly to for-next branch), Mark?

Yes, that's fine for me - for v3.11 I suspect it'd make sense to have it
in my tree though as there'll probably be other stuff that depends on
it.

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRdQhgAAoJELSic+t+oim97pgP/i+1k1WkMIIZhBG1Y79PKdHd
Pkw68kVRrcPBb3d33A0hYGp/9pRzrk7wYNwKdAjIV0Lbp0uyl+4a3OgkR4f8MMl+
YU/OXxgKtY7WlvriPF0AaeMqncbemkB+5IYoOjvgImcb/xxMGxNOwcoy8f1M0qNp
xB0MMheOgi0x7jgQLTSaVhHoM1x91uQ1LqsoPqeF5APGYr9b2xn6irThBuXx2CDO
ZW7L9LXokorUYKAbF/N/YRZ2xDzJdE3bhZkAxFtJPqubDNO2XNJjLd6bf6IOJSj2
sU7bldbd+DhMfAFQHYUNA1hMsi2OxqFtPMMQOl+wKTFPTDnJeiAaw5tCmayGUw81
ZbnxR4NnC+uXQEys8K7N8aqAegJ/8/W1vapPpiNQAyrmaZZUEABjmcIv6ilfGA78
z6a7f/vBYtTuSCqZuYIKl6B0qB5SOBc/LV9JGstoyT63dtvUs8HtoTDaM2P9eGDl
kY11IL+A+2EhyN93dLgEYMSF2/GeTc6e4IEIyWs/HoKCGn3UXgnpduJMbJxmP8KW
kmhNBAeaUw1CkOXPfTl9KNqy5lZuIE6tQU5HT4sSSRlU+QE8KfJaIOjSacG03lnJ
9mdjNd0U9TGmtED2D1xwJDh1jBf8RuNqj316/pC/7r8nrqaildHV8S3cePLLZEy8
SeIzYtlKKV2KBHRLUEgR
=Emvt
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

--===============6528622610280667968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6528622610280667968==--
