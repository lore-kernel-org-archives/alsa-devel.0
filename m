From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc: bfin: use dev_err to print error log
 instead of dev_dbg
Date: Thu, 21 Jun 2012 11:47:43 +0100
Message-ID: <20120621104743.GT4037@opensource.wolfsonmicro.com>
References: <1340301118-3800-1-git-send-email-scott.jiang.linux@gmail.com>
	<20120621100841.GP4037@opensource.wolfsonmicro.com>
	<CAHG8p1ACFtV0p8c8MQFSVDuBUX0y-CTw_uXXXyPaZmHRYXZfBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0363362302756620679=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B7C0310B985
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2012 11:26:32 +0200 (CEST)
In-Reply-To: <CAHG8p1ACFtV0p8c8MQFSVDuBUX0y-CTw_uXXXyPaZmHRYXZfBw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0363362302756620679==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MOeiELSuYwpLEKvX"
Content-Disposition: inline


--MOeiELSuYwpLEKvX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 21, 2012 at 06:29:40PM +0800, Scott Jiang wrote:
> 2012/6/21 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > On Thu, Jun 21, 2012 at 01:51:58PM -0400, Scott Jiang wrote:
> >> Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>

> > Applied, but as I said last time you should use subject lines that match
> > up with the rest of the subsystem.

> Sorry, I'm not sure what you mean. Do you mean 80 columns or style?
> Could you please give me more details?

You're calling the subsystem "asoc" not "ASoC".

--MOeiELSuYwpLEKvX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP4vt5AAoJEBus8iNuMP3dMZMP/3zWjuDvtEd5/t0LwR7dnnNX
RIiwKHRRTuBLEfUUaCb1KNmXJJJhLYpJC69+NWHymbq/OhiqXb5VPJn5sfScaTBO
QVCr68XxYlrZgfEPP4bTZWjIGuYIPQz95d9lJg2T1XFko86YhFWQb0YVoyfJuCWJ
v4oUuw6cTdH+YQymW+jTqBWnAR2frBaCK28FaxAdlMVJ+jLlt1LbDe1glHuywQSs
NJRUZRMwlMt+lMOs413Ihc7+84U0CqzSi7wXegNtg/9uXot/NJnkss4EaQm7VbNB
0oPiuuEPRkdjdO216JJP+yqPzy9wBsVSK7yjXH16CbT6w8ZQH20UN+/PRO3TYIzG
2OSp+QFRpq7Hwn91rHttgvMfTwaqvDTQ4oeGGi0zH3nfYRvppenkOFibtjBBQ2KZ
BCkS20ZHsaR1tc5BJSj1XAn6HWq32807BC24jJC/EOdYgVl5gAPdipCJfG4Ja94e
EU/ofyrKcY9XfJm3NIuju+poUj0u75eIwgGyQqrZu53QSYsnClmiWfoRrgFMx7tu
VYu0qKGs/WL0R6z3ETpiKFWOQf2Do10xqy0BTBLneiofCKMlxRO1jhLdWj2lzWzC
Urg5Ch6oJa0J/Rm8mJ67iCx0naa5BxcObOns/uT4wibk35GPsULwfV8NYRdI1TA2
4bcdjeycPa+djpHYjo2G
=qowO
-----END PGP SIGNATURE-----

--MOeiELSuYwpLEKvX--

--===============0363362302756620679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0363362302756620679==--
