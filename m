From: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: [PATCH] alsa: correct nonsensical sysfs device
	symlinks
Date: Thu, 25 Jan 2007 16:15:47 +0100
Message-ID: <45B8C9A3.6060107__28618.5340643444$1169738316$gmane$org@drzeus.cx>
References: <806dafc20701241750t53b86babn36831cadc7dfa76c@mail.gmail.com>	
	<20070125042616.GA21813@kroah.com>
	<806dafc20701250611u9935049ja8f88deb2aac4d40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1702802315=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp.drzeus.cx (85.8.24.16.se.wasadata.net [85.8.24.16])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EECDE324
	for <alsa-devel@alsa-project.org>; Thu, 25 Jan 2007 16:15:54 +0100 (MET)
In-Reply-To: <806dafc20701250611u9935049ja8f88deb2aac4d40@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Christopher \"Monty\" Montgomery" <xiphmont@gmail.com>
Cc: fedora-desktop-list@redhat.com, alsa-devel@alsa-project.org, jrb@redhat.com, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, mclasen@redhat.com, Lennart Poettering <lennart@poettering.net>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============1702802315==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=_hera.drzeus.cx-15074-1169738151-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-15074-1169738151-0001-2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher "Monty" Montgomery wrote:
>=20
> My machines and the fedora rawhide machines using the 2.6.20-rcX
> releases look nothing like what you pasted.  If they did, hald would
> be working...  (I'll note that bugs have also been logged against
> Pulse and HAL by users having trouble, so it's not just us.)

On my vanilla 2.6.20-rc5, I get the same structure as Greg. Yet hal
still doesn't pick stuff up as it should.

Rgds
Pierre



--=_hera.drzeus.cx-15074-1169738151-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFuMmm7b8eESbyJLgRAqFZAKDopl+cjrHCZioft8A4U8ZtzDq/WQCgzgxw
hLnWlIwJKEIhgo7+GYnrY6w=
=4jgf
-----END PGP SIGNATURE-----

--=_hera.drzeus.cx-15074-1169738151-0001-2--


--===============1702802315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1702802315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1702802315==--
