From: Valdis.Kletnieks@vt.edu
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Mon, 10 Jul 2006 22:09:51 -0400
Message-ID: <200607110209.k6B29psN007504@turing-police.cc.vt.edu>
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de>
	<1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
	<1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0637255908=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from turing-police.cc.vt.edu
	(pool-72-66-204-177.ronkva.east.verizon.net [72.66.204.177])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EEEA7223
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 04:09:58 +0200 (MEST)
In-Reply-To: Your message of "Tue, 11 Jul 2006 01:38:39 +0200."
	<44B2E4FF.9000502@pg.gda.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: =?ISO-8859-2?Q?Adam_Tla=B3ka?= <atlka@pg.gda.pl>
Cc: alsa-devel@alsa-project.org, ak@suse.de, linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>, perex@suse.cz, alan@lxorguk.ukuu.org.uk
List-Id: alsa-devel@alsa-project.org

--===============0637255908==
Content-Type: multipart/signed; boundary="==_Exmh_1152583790_4450P";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1152583790_4450P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Jul 2006 01:38:39 +0200, =3D?ISO-8859-2?Q?Adam_Tla=3DB3ka?=3D =
said:
> U=BFytkownik Lee Revell napisa=B3:
>
> > esd and artsd are no longer needed since ALSA began to enable softwar=
e
> > mixing by default in release 1.0.9.
>  >
>=20
> So why they are still exist in so many Linux distributions?

As soon as somebody writes a patch to make the e16 window manager talk AL=
SA
rather than use esd, I'm heaving esd over the side.

Of course, I've been saying that since ALSA 1.0.9 came out.  (And don't
suggest I write it myself - I could if I was motivated enough, but I'm no=
t
motivated at the current time. :)

--==_Exmh_1152583790_4450P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEswhucC3lWbTT17ARAhdwAKD6LORdtti4AHXf2rkazFe9VVvmVwCcCZR4
MKS1rlYYDh5NQaOKL8sZ9o4=
=HPen
-----END PGP SIGNATURE-----

--==_Exmh_1152583790_4450P--


--===============0637255908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============0637255908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0637255908==--
