From: Jordi Mallach <jordi@debian.org>
Subject: Re: Fwd: via82xx problem
Date: Tue, 15 Apr 2003 14:59:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030415125903.GA22059@nubol.int.oskuro.net>
References: <3E854FD5.7070801@boosthardware.com> <s5h1y0nkjpt.wl@alsa2.suse.de> <20030402225838.GA5225@nubol.int.oskuro.net> <s5hadf7sx7o.wl@alsa2.suse.de> <20030403220725.GA14648@nubol.int.oskuro.net> <s5h3ckysdtu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h3ckysdtu.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2003 at 01:26:53PM +0200, Takashi Iwai wrote:
> then perhaps it's not a bug of via82xx part.
> is the mixer configuration correct?  please attach /etc/asound.state
> to be sure.  also, please try the latest cvs version.  i changed a bit
> via82xx.c yesterday.

Hey Takashi,

I finally had a chance of testing the CVS code on that box, finally
sound works again.

Thanks,
Jordi
--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/~jordi/

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+nAIXJYSUupF6Il4RAmOQAKDQ8esTXWqfa3zDN6Z62yCHW1cBtwCePehr
DKb4rY9Ukgjyyl6Mb9Ddh7A=
=pJip
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
