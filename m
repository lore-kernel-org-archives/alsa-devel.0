From: Jordi Mallach <jordi@debian.org>
Subject: Re: Which linux distributions and when?
Date: Wed, 16 Apr 2003 13:21:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030416112126.GC29596@nubol.int.oskuro.net>
References: <3E9C5B9D.6020902@Eng.sun.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3E9C5B9D.6020902@Eng.sun.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: RAJA DORAISAMY <Raja.Doraisamy@Sun.COM>
Cc: alsa-devel@lists.sourceforge.net, debian-alsa@lists.wedontsleep.org
List-Id: alsa-devel@alsa-project.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Raja,

On Tue, Apr 15, 2003 at 12:21:01PM -0700, RAJA DORAISAMY wrote:
> I would like to find out which version of popular distributions
> such as RedHat, Mandrake, Debian will bundle ALSA support.
> Suse already bundles ALSA in its distribution.
> I have not been able to get any information regarding other
> distributions.
> Any information or pointer is much appreciated.

Speaking as a member of the Debian ALSA team,

Debian supports ALSA in the current stable release and in the upcoming
versions.
I don't know how SuSE handles it, but I assume their kernel has the ALSA
patches included. In Debian kernels, ALSA isn't merged in by default,
but we provide ALSA module packages for them.

Debian stable has 0.9.0beta12, which is quite old, but people can just
get the packages from the development branch and stick them in their
stable box, as they work smoothly.

Jordi
--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/~jordi/

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+nTy2JYSUupF6Il4RAnVwAKCd5/AL0hHM0JkzaIxa7Eo2r38O5wCgzgZt
fMDsIs8gF7EVKTmvIOEq5F4=
=CWL7
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
