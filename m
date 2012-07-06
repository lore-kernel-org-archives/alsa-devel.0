From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: pcm: Clean up logging in
	soc_new_pcm()
Date: Fri, 6 Jul 2012 19:02:26 +0100
Message-ID: <20120706180226.GA5437@opensource.wolfsonmicro.com>
References: <1341590092-20713-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0311355962857872406=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D654A1045A2
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 20:02:28 +0200 (CEST)
In-Reply-To: <1341590092-20713-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0311355962857872406==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 06, 2012 at 04:54:52PM +0100, Liam Girdwood wrote:
> Use dev_ style logging throughout soc_new_pcm()

Applied, thanks.

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9yd9AAoJEBus8iNuMP3dnTIP/1RB83g17HpEvdGOTuzyzJR6
Q6f0NtraR7TppOVauVkuc0HMi8Or0EbtdlNN1fmXM27xVNvO3BRrYRVYwXMpmHC+
nrOVDE++iXGejAXAHqPR+cjjnyZOjKllazqhvwdEsdGfbsqgsTDexkvyn5ThTcSe
bKgDWNqREaQpBvP7x6NRffuntnwBRF+RxhVjSSRBrKgUZNE/MBgxQd20YMdVEMu+
XwjFtjjPspbegdRcejCLWuA8FFVADIKIRYhMuqYayWMipABYpktR87w/Fe6vxPRu
WDbEFS9LFJLaPMdOK6pUoqYu47U/NiESQEqNDIzUvcutzcOilqun4+bhcdemWqzE
9NWkSy0ArVh0ffD8YuzDYjJ2ZJEFqizfDLNpp8JzGEpMEm3PousDo0ZJ1zRzeynQ
F25atVya4XrXD9bVzIyslpVwBO1SDQUPeOwAGiy9zk+ZNjqIb8InqG24VTMt3QPg
A2+AXokmjM8hxUq0If9RjxG3u5S9pu/4qqHvx9GsNhRxZ/gIegFo6huS+xZ8IjdK
BLDTdiApxOqkGEWsKszDgoCVXVl11yh3a8NOjyMv4aHDnPbpIXe8IFEd01/RT2N3
is/5fKo8JBr8gJ15RRJuiIChxXCXU8v9yHH5PQS7Oat2VQ1R4dWGyREm9I8NVbC9
pP8HVcF+lmR2Fi5MvLvt
=P0mD
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--

--===============0311355962857872406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0311355962857872406==--
