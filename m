From: Jordi Mallach <jordi@debian.org>
Subject: Re: unresolved bugs in the Debian BTS
Date: Mon, 10 Mar 2003 17:48:16 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030310164816.GC11136@nubol.int.oskuro.net>
References: <20030306181713.GA15224@nubol.int.oskuro.net> <s5hk7f75vn4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hk7f75vn4.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2003 at 12:05:51PM +0100, Takashi Iwai wrote:
> thanks for the summary.

Thanks for the feedback. Very helpful :)

> > ########################
> > Bug 108572: PCI IRQ sharing with USB will crash ALSA
> > (against beta 4)
> >=20
> > Null pointer dereference when loading the cs45xx module.
> > Another user confirmed this for rc6, but now with kernel panic.
> >=20
> > http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D108572
> >=20
> > Would be nice to have a look at this one.
> =20
> hmm, it's difficult to guess.
> we need a trace from kernel oops.

Will ping the submitter, and close it if we get no answer.

Thanks for the rest of hints!

Jordi
--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/~jordi/

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+bMHQJYSUupF6Il4RAsIPAJ40amJlou+2/m84EdAfMwVcGctmsgCeNNys
1gQACVfrNE9GDlH9KxvcaJY=
=TELO
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
