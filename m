From: Martin Egge <mailinglists@martin.egge.info>
Subject: Samsung P50 Heaphone Jack-Sense not working with
	latest ALSA
Date: Tue, 23 Jun 2009 14:25:39 +0200
Message-ID: <200906231425.47946.mailinglists@martin.egge.info>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7874441982800965658=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 05C22246F8
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 14:25:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============7874441982800965658==
Content-Type: multipart/signed;
  boundary="nextPart2627349.fDkGMpSud1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2627349.fDkGMpSud1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

last year Takashi did help me to get the digital output and the=20
internal/external mic up and running on my Samsung P50 notebook with an=20
integrated Intel Corporation 82801G (ICH7 Family) High Definition=20
Audio Controller.=20

Some time ago I switched from Ubuntu 7.10 to 8.10 and a new problem with th=
e=20
soundcard occurred. The Headphone/Line-Out Jack-Sense is not working. When =
I=20
plug in my Headphones the internal speakers of the notebook aren't switched=
=20
off. I've ignored that problem for a long time but now I'm willing to chang=
e=20
this.

I've already upgraded my system to ALSA 1.0.20 with a script provided in th=
e=20
Ubuntu Forums [2]. I've used the build-in support for the latest snapshots=
=20
provided at [3] of the script. But the problem still exists.

Can anyone (perhaps Takashi again) help me?


You can find all ALSA related information about my system at [4].

Regards,
Martin


[1] http://tinyurl.com/mkw8mz
[2] http://ubuntuforums.org/showthread.php?p=3D6589810#post6589810
[3] http://tinyurl.com/5ux2nf
[4] http://pastebin.ca/1471032

--nextPart2627349.fDkGMpSud1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpAycMACgkQVG/GfU56d2wJpACfSQ2xdodhAryEt6cJirl264uG
iu4Anip+TqtX1jFGkSHpEBxRW/50GHnU
=7gP7
-----END PGP SIGNATURE-----

--nextPart2627349.fDkGMpSud1--

--===============7874441982800965658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7874441982800965658==--
