From: Jochen Voss <voss@seehuhn.de>
Subject: Re: [alsa-cvslog] alsa-kernel: emu10k1: Fix outl() in
	snd_emu10k1_resume_regs()
Date: Wed, 4 Oct 2006 17:52:06 +0100
Message-ID: <20061004165206.GA5479@localhost.localdomain>
References: <ALOGGER1159978767.86@alsa-project.org>
	<4523DFF2.4020105@superbug.co.uk>
	<85r6xo598c.fsf@orfeo.duckcorp.org>
	<4523E4A5.3010407@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0342023129=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4523E4A5.3010407@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0342023129==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Oct 04, 2006 at 05:43:17PM +0100, James Courtier-Dutton wrote:
> I meant, how do I find out who committed the line with the bug in it.

For git there is git-blame which annotates each line of a file with
information about the last commit.  I do not know about hg though.

All the best,
Jochen
--=20
http://seehuhn.de/

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFI+a2f+iD8yEbECURAj1fAKCptiSh64j2eBW+HD+Rgb1PNnyX2gCePgXq
GGSLvC1xceDpagta7yEJluU=
=Fmbf
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--


--===============0342023129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0342023129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0342023129==--
