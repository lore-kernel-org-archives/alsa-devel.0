From: Jordi Mallach <jordi@debian.org>
Subject: Re: unresolved bugs in the Debian BTS
Date: Thu, 6 Mar 2003 19:23:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030306182353.GA15360@nubol.int.oskuro.net>
References: <20030306181713.GA15224@nubol.int.oskuro.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030306181713.GA15224@nubol.int.oskuro.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, debian-alsa@lists.wedontsleep.org
List-Id: alsa-devel@alsa-project.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2003 at 07:17:13PM +0100, Jordi Mallach wrote:
> As promised, here are the bugs we have on our bug tracking system.

Damn, forgot a nice one:

Bug #100041: /dev/music MIDI adds unwanted staccatos on first "long" note a=
fter seq_reset()

Have a look at http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D100041

It includes a testcase, which I guess it wouldn't help me much, given my
0-knowledge about music :)
The bug was reported against beta4, but it'd be nice to see if the bug
still applies.

Jordi
--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/~jordi/

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Z5I4JYSUupF6Il4RAitjAKDlWTt/2p6roMu/HXbd6FISV9S2OgCfTAHA
WBlov2gkVuZhvjwi78xAATI=
=k1Qd
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
