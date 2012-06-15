From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-mcpdm: Convert to use devm_*
Date: Fri, 15 Jun 2012 10:11:48 +0100
Message-ID: <20120615091148.GA3898@opensource.wolfsonmicro.com>
References: <1339750500-16517-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3388957862573954279=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 715A324663
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2012 11:11:52 +0200 (CEST)
In-Reply-To: <1339750500-16517-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3388957862573954279==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 15, 2012 at 11:55:00AM +0300, Peter Ujfalusi wrote:
> Switch to use devm_* te make the probe/remove code more cleaner.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP2vxMAAoJEBus8iNuMP3dt6AP/jezlSio0ofwX4IVd3NErCEh
rTkARRocoUUqBZHigDT3r2A8SlST+ccnvU12IgZAc41wzP4CwpHF2moRShmvMq2t
kiyWu8PyJM7mTbkGhuFBK8ezlgLBZ6B99C70kXHfVPG44wCbLmKC+YWzvbRkMMhC
quakOE3ebqJh63lbvMOTVvLAav2e5XkLWdqXQu1dGOI5WFiFATj1B8oU7gmqLF7o
cEy72C1wgDhv9kMup1bu5BzKO+BBC11QHfw4f5th1wALupjwvh9IfZ7UKo+2BlVr
v+WHnbxbhAoS5Peav+ixuJuojN+FZ5C3iRcGDRe0hfdUpc8DTAo+1XE0sXxj2C/R
+qIDH9CDdtrcKNLpiiy+KHv10/91fWLWC+nYa/EG1IBdyQBDacMuCBhW1rGVI/47
nuSOiBDPqCkR/D9yDZEv2omgA67N3SCJmmx3bP9XNG6MDtetObOT9DrWLy7tfA/2
vJ3+6HWt+oxWDUil+hSD8ZkdXGFTJnF0EzP22tNBGU/d3xJPeqEwSSQtiABXW1xU
eUMsUEtKP6tyrT3d92+Mo5BvdS+ljZHwPY6FfqbHcc/zERE3nDpc2m+XsJG5ah3G
ab1Ahvxgxmvs2iIpyYhYtV70JMVvvBqfN3TNUXvmHM+miuXnb93nsm6LZDu2x4H9
Sbql7FLoaCEvozwcXFx2
=Ei8L
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

--===============3388957862573954279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3388957862573954279==--
