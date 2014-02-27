From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sta32x: Fix wrong enum for limiter2
	release rate
Date: Thu, 27 Feb 2014 16:53:17 +0900
Message-ID: <20140227075317.GV9383@sirena.org.uk>
References: <1393483292-30412-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6811841270940727157=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 547F72657CA
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 09:16:24 +0100 (CET)
In-Reply-To: <1393483292-30412-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6811841270940727157==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="finhkSr2yyrWw3ow"
Content-Disposition: inline


--finhkSr2yyrWw3ow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2014 at 07:41:32AM +0100, Takashi Iwai wrote:

> I'd like to put this as a quick fix for the next 3.14 pull request.
> So, if you don't mind, I'm going to commit to my tree for-linus
> branch.

I actually have another small batch of stuff to send you anyway, that
earlier lot was flushing out a pull request I'd generated but not sent,
the next one was going to appear today anyway (just waiting for a little
while for the zero day tester).  I'll roll this one into that if that's
OK?

--finhkSr2yyrWw3ow
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDu7oAAoJELSic+t+oim9uXoQAJ5gdVdfIzuvOcY9PcpOwKpu
osZrp9YTI8p/0jK+JvVs0SK7W9LT8aHBEkQetXyMpH95aRexzerIJ6iYQEUjdPhw
JbDUKoRkjLzPBl9Maq0Za8ZMBh1aGC0b203DWnurw7pC4iukZFABdPDSQWAkUJf8
Rmketq8tKqTwPszxtt8AQ93S9VgXlGcZn9Vxwc5lSM61tk68X2/f01hua2wQZsCV
tZm9eDovMLO4UXHaw0/TZVKn+TWVMW/Ox5FcBZimwcIzhh1MY+6GEwy5En4kbO6o
3UelTKfwmMggIMns0mn4GmBHQ5nFw7rg54fyqH0dIfYGJw5CcAEF/8g4VOUqxEoR
savLX98PizE3tIgjT53TR0/QbxVqA/n9ScQPdXBTqYy1lKfzo0xuflHFatXwFv1I
gOYbv45ARBb8RlH9rrXQlxoKfkVLQiwPh0KJJvTN2dK2TKL/brbBi/Ydd5rW+8DI
FDN1p7JXBFkboW5MRpoe85lVhuY406OWk31RHA70VY4/qkoGF4PkNWePwp2sBRY4
C2oz1+0lmV3jmH3kclnktITk1mOqqt3zJ4pTqN+8y1V21LB/F51RecwbDYZo0mvF
GGLWvRJmLjkePJWyUIyhmr1YC1nxKZ9bhqntF9qKmboKLNIlwG4p0D9lkjLtxyjR
INIkh0M/al1VxPiTOxzN
=Yg4J
-----END PGP SIGNATURE-----

--finhkSr2yyrWw3ow--

--===============6811841270940727157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6811841270940727157==--
