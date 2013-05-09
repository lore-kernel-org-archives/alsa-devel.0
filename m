From: Mark Brown <broonie@kernel.org>
Subject: Re: TLV question - ranges not in volume order
Date: Thu, 9 May 2013 11:12:17 +0100
Message-ID: <20130509101217.GE7478@sirena.org.uk>
References: <518A3545.8000809@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2502857875762644393=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C09EC2619F4
 for <alsa-devel@alsa-project.org>; Thu,  9 May 2013 12:12:19 +0200 (CEST)
In-Reply-To: <518A3545.8000809@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: rex.tsai@canonical.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============2502857875762644393==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F3Ja72XjDYN1ox8a"
Content-Disposition: inline


--F3Ja72XjDYN1ox8a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2013 at 01:21:41PM +0200, David Henningsson wrote:

> I recently came across a strange ASoC volume control. In this case,
> the values are not in volume order, i e, the control is declared
> something like below. I believe the numbers correctly match the
> hardware.

Oh, joy.  What driver is this?

--F3Ja72XjDYN1ox8a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRi3Z+AAoJELSic+t+oim9egcQAJrIwmpBv/T46aApk9EjChqB
n5jXGJFcTzZXMS/bvBUuxlMLJ1v4Yla02C0Jnb7w7QYlSOlJIc5vLdHSjRDuQ1CN
OpQXNy735+GgLP9BWFBHfyx3BbItL0PT70qT+YTgF95L5EGtIb64d6hv7ZJ7Iw/C
/JJOSwTlJjUFeJbxvKrrazKZGwMiqpFLdeNXmOhuYSSb3FJOYsiQTToqEnU7tMBN
Tg69TMlzXLTUaom5ZWqAVLcCsG7EQKr/6YCc3pDi2x7n97/4W+fPsjInGT/yEpYR
FhfmbEb+CU+4Tw9CsDvITIR5Wb8SlhZ8AU7alXV/+/0lCSPBZ9AKvlX6IRrdR2Ni
217BY2o7zQj9I3jxn3mG5H86hpmFijvXRrl6FpRSlMdTudoGmHc1Nd43XsAuSkLC
ZquRRzF3bmmQQozFWdPVCAYfI8WkQiFSC2wxfxpVrcWz1nhYhtR0IzsMbBGAwlQo
qx4QfRDfdLB9lwCSJUj9CMd60PP6JNcpL1TiFw2Ra9GX3WQnOMtDxf1O4sKL4c22
HsxgN+vtXrJBkm7Vhn4Ba0ZL9vNJunKo7SYwzkuSoU0fffkqjHC45LqPIXLIjMyW
yPwe4an0GnLCUS+d+zR+26bmGSPVfNPVOhmQRsl/PwjPUi9Sv0yUi/ETzMM3cwi5
rJrOBWuBTh+YWQb0028e
=thji
-----END PGP SIGNATURE-----

--F3Ja72XjDYN1ox8a--

--===============2502857875762644393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2502857875762644393==--
