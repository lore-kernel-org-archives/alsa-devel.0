From: David B Harris <david@eelf.ddts.net>
Subject: Re: Removal of /proc/asound ?
Date: Tue, 20 May 2003 01:09:04 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030520010904.4a389604.david@eelf.ddts.net>
References: <20030517081625.6ef24458.erikd-alsa@mega-nerd.com>
	<Pine.LNX.4.44.0305171343140.21997-100000@pnote.perex-int.cz>
	<20030518081331.7b9eca31.erikd-alsa@mega-nerd.com>
	<s5h4r3re0a8.wl@alsa2.suse.de>
	<20030519200301.1c3276f7.erikd-alsa@mega-nerd.com>
	<20030520044030.GD24175@vergenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Q,Z6:'mtZfQu)C"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030520044030.GD24175@vergenet.net>
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

--=.Q,Z6:'mtZfQu)C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2003 14:40:30 +1000
Conrad Parker <conrad@vergenet.net> wrote:
> On Mon, May 19, 2003 at 08:03:01PM +1000, Erik de Castro Lopo wrote:
> > 
> > I therefore strongly urge you to keep 2.4 functionality as it was and feel
> > free to do whatever is needed for the 2.5/2.6 kernel.
> 
> erik, you're hassling the wrong people -- a script exists to make the
> devices you want, this is a packaging problem for el Debian ALSA Psychos
> (knowing that erik uses debian), and a bog-standard GOTCHA for CVS users,
> unless it can be done by make install or something.

One of the Debian ALSA maintainers here.

The removal of /proc/asound/dev/ has been noted, and shouldn't be a
problem :) Once we actually upload packages within which
/proc/asound/dev/ has been removed, anyways. We haven't yet. I doubt
erik is bitching because of this, he hasn't asked any of us about it.

--=.Q,Z6:'mtZfQu)C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+ybhwuCQ/g7GxJcARAot3AJ9aCegoOzywurSwghJve8AgCVMLoQCfV+hs
nSPLi3pGQD0why1K7n04Jmo=
=ZZaL
-----END PGP SIGNATURE-----

--=.Q,Z6:'mtZfQu)C--


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
