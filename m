From: Gorka Olaizola <gorka@escomposlinux.org>
Subject: Channels jumping with snd_intel8x0, nforce2 and 5.1 output
Date: Sun, 4 Jan 2004 18:55:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040104175552.GA16063@helvete.escomposlinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I've been experimenting with a Nforce2 mobo during last month and the only
thing I couldn't fix is this sound problem with 5.1 surround sound.

I have read all the messages in this and other lists refering this problem
and I have tried 3 different versions of alsa drivers (0.9.8, 1.0.0rc2 and
latest cvs 1.0.1). All of this present the same problem of jumping channels.

When seeking in mplayer or using speaker_test the channels change their
positions randomly.
I know it's a known bug but I want to know if it's on the list of bugs
to fix or if it is a bigger problem like lack of documentation or something.

If there is a way I can help or something I can do to isolate this bug tell
me.

Thank you

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/+FOoAJWwPWWa2yoRAjwaAKDGWeO9aqLNvOHEUvaKxH8RKVRrwACdFxJd
cExpaoZ122Wrf8aoMlf5BXE=
=faL5
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
