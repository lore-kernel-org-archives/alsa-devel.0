From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFT] ASoC: wm2200: Fix setting dai format
 in wm2200_set_fmt
Date: Fri, 21 Dec 2012 09:34:39 +0000
Message-ID: <20121221093439.GC26183@opensource.wolfsonmicro.com>
References: <1356078517.8338.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2936044140708476024=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6268D265277
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2012 10:42:39 +0100 (CET)
In-Reply-To: <1356078517.8338.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2936044140708476024==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 21, 2012 at 04:28:37PM +0800, Axel Lin wrote:
> According to the defines in wm2200.h:

Applied, thanks.

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ1CzdAAoJELSic+t+oim9pEIP/jYKWLXi+66mB3OyrPiU/fts
ae/yw0qZPXkTMR9Ic0Jch3+3fJHq213FsJKao4YQReGL2uQDhrGd5V2P69sKqYBl
OuB0BhwWPh0vURARVVv+bOpy9zcijLlaao2whXFAfx/fpgTCf4KW9d7mUFieqKm8
/c2z7DlnoX8lnnOoRFbY3GniUH8n7HD0bQVnACxpolxyPsGr+IR9uP/9LELQzkWG
9xs8iCnwRdXU9n0BagqYAi+Rbt/RKF7IKQaIQsdqaKmG1SBzTv9KIp7s6HfAIt0V
XfR2WNeNzTBbWuE4yrMzJx5pEOOj3jPaiZAi/DX49IawwI4RBIbBejrItFskqKgK
AuE8iO1ASf1SE78oQQAqBVF7h0eiZIKKuYyx59WYBz1Iu9kvfTuizwHMQRgaJjZn
vtnn6o2IEZ6g62wohxh98myJ9qD+Y/OfPucIsZ9xduNZjCpve7XD8oB/8mKR60qd
cb/xj6fqKZWyLB6GFjtmHXKs5bUPcM85GE+yfpmcG95KYMDTWAb3tqswN+NhbGxc
ftFagD6AmL9b9n8iajBMbsr+epY5fSAt3Lpz+hUzVTd70WXHrSugkOq8XiUVQ6fA
KBx2ZsHa8a08CdDhMGplsRe97sfoOz0oCbu/bcUgEuQ7y4bE077CDCDx7qOdGl2+
mXrs9ZJbs2ROfOUc/iFB
=c/YC
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--

--===============2936044140708476024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2936044140708476024==--
