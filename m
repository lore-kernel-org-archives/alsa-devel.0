From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: soc: pxa2xx-ac97: prepare and
	unprepare the clocks
Date: Mon, 9 Jun 2014 21:35:33 +0100
Message-ID: <20140609203533.GZ5099@sirena.org.uk>
References: <1402343952-1287-1-git-send-email-robert.jarzmik@free.fr>
 <20140609201156.GO5099@sirena.org.uk> <8738fdzv3y.fsf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3695641767631138072=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 874FB2651A2
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 22:35:49 +0200 (CEST)
In-Reply-To: <8738fdzv3y.fsf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3695641767631138072==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f7CucRmdyxBKZyr2"
Content-Disposition: inline


--f7CucRmdyxBKZyr2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 09, 2014 at 10:27:45PM +0200, Robert Jarzmik wrote:
> Mark Brown <broonie@kernel.org> writes:

> > Applied, please use subject lines matching the usual style for the
> > subsystem.

> Oh yeah, sorry.
> Next time I'll "ALSA: pxa2xx" if that's the correct one ...

ASoC: - in general just do a git shortlog on the file(s) you're changing
and look at what people are using (unless they're massively inconsistent
of course!).

--f7CucRmdyxBKZyr2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTlhqRAAoJELSic+t+oim9gxsP/1+Dg83WEEc3ft9aDIzL6g5n
EhhH4PWBuKghlmFdgwF+LzjMNuhQakbA47smWwmVoeNjUG4v40UG1xYK6hSnfFzo
YCm/CfTQpbh89vI44g6ufc7s4kF0wNAG+0tjZr/jQXs1LHiVRLyoXH3pH9+xSC2p
1QGC3ai7oXvjc260tbn1BGP5e6hhsciKEGyQrdglYduoTenNOEngDQPdsDv5URlk
StYDZVI8mbR/Dr5wdhnRqimSK+Ocvj0KE3T/VNyQiFwzgrD/4KBgWtfiLyA5KHhs
+g7phT5wCpSW4nr3S4wuMSOU0lXZJfiqd+q4y6XbwsS6I2ROGZOkv5Nxdr+NsocL
Um9tFBDcM9BvDP5USS2545ByMkhaWScpCFqbdcokIinR3bqhZZjiHBim/x+sPhqe
d+ni/kCcI6SJxz5utHPTvJxAM+VuHr2vZ28cLS4Acsfj3ifukvb4O5LO6Ni+lPEK
lVz3fidINK19q6PzdO29GBRwcoMIROhOiywgkBByvNpQO5WLSnz4BkDQf8PR8rgb
cF6tYAMvDjeRMNiIJoJ5+yomXmq4R7tor+t02HjEeqWQ85k4Ul2TbFGdL4G8aTr5
aJh6yoGG7QDmdK2Zoxu6nq3N4Lop4p+waSKSR19e4PrvN+fJRHylU5TZVkSxtJxV
MGjNFMUXfIEFQWO42Xm0
=O2fr
-----END PGP SIGNATURE-----

--f7CucRmdyxBKZyr2--

--===============3695641767631138072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3695641767631138072==--
