From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: dfbmcs320: make the driver common
 for other BT modules
Date: Wed, 22 May 2013 11:03:42 -0500
Message-ID: <20130522160342.GN1627@sirena.org.uk>
References: <1368879900-28395-1-git-send-email-Baohua.Song@csr.com>
 <20130521181849.GG1627@sirena.org.uk>
 <CAGsJ_4x3QrvReOnFQFqRMWfUf-v-Js4+L_Vr8jht_wR-ApQJrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5566868173343411171=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 338BC260785
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 18:03:53 +0200 (CEST)
In-Reply-To: <CAGsJ_4x3QrvReOnFQFqRMWfUf-v-Js4+L_Vr8jht_wR-ApQJrg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com, Workgroup.Linux@csr.com, Graeme Gregory <graeme@openmoko.org>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5566868173343411171==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lPld9KzQhYxXHcUh"
Content-Disposition: inline


--lPld9KzQhYxXHcUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 22, 2013 at 01:15:26PM +0800, Barry Song wrote:

> thanks, Mark. can we also do something in omap-hdmi to make the HDMI
> codec common as well?
> i think it is in the same situation with BT SCO:
> http://comments.gmane.org/gmane.linux.alsa.devel/108234

None of the OMAP guys have reviewed that yet and you only sent it last
week.

--lPld9KzQhYxXHcUh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRnOxbAAoJELSic+t+oim9cVUP/1KlnuXB4urkOm78apjKex9x
QHxZEKXV3iMp6HRrFYEfn02cb2HtsORxZG+zuSMzJaBjzcnma2oA8xqmdLeCg3FT
KumfCFzLlWp6N4vanG1swsOHql5a1qMt37y+cYb389B1zPALkZj7U044iV/SJsIM
2rDCF7p/jy2wSC58GNofUVm6t3JmX/lnY9tUvW0iX6I1r7tgUthX71OL0k2wULL1
jjGk34aIT4BH5XUD8dQ+zi7u/UpL4dz7Ces7dmy8sSmy8HFxK32TFDDkYFC2dKnU
Drw4YARYnXj/yv6dnOOwWrjHOLmr0QBJIJca1m23ZoS/x3UFAYR8bWMVQ2pvKoY/
T2Ezwu2PA0B8YUQN5crrSKTD99ICFxhZn6nG9w+A1e963GApzMvgAZaqgnRuWvVm
vWv1TyNNPoT800B5PvWJtvFVxmpkNk7CQ17Kr3O61PLC95rfpdkLSXkIGcZvNBzQ
1AG/lC22/u0UR4ypAWkhDHqTuXYBM8Ff2ywyDdp7TwmYw4tND0lkwBdoWeNtvxj4
04tO+Omwzpdcv2eSO4NaAJzwr026siPHcp28KDtPVC0cTUQ4FLxVD0ZQKPq+cJTM
zyGujatGDVuOphf/tUGk2OmxwVMYnlpdNDcNJW1D4nWanzEoSEKgdOhjtBJcEbuR
DoCYK78NNCuhTPOFlrcZ
=GLbA
-----END PGP SIGNATURE-----

--lPld9KzQhYxXHcUh--

--===============5566868173343411171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5566868173343411171==--
