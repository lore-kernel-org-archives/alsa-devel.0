From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: cs35l32: use true/false returns
 for bool functions
Date: Thu, 28 Aug 2014 19:05:23 +0100
Message-ID: <20140828180523.GE29327@sirena.org.uk>
References: <1409238162-13400-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8771676849984261288=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B2C726A797
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 20:05:38 +0200 (CEST)
In-Reply-To: <1409238162-13400-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8771676849984261288==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 28, 2014 at 10:02:40AM -0500, Brian Austin wrote:
> Return true or false instead of 1 and 0

Applied all, thanks.

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/29gAAoJELSic+t+oim9yWQP/2Nr/5QMeskblE1fnoU7LDcP
0U9kPyME5BEtKIzZmVJYte1TYDWO7Q4oxuSqYH0BubvhMk2H2LbsmlOe0/O8lF1F
xJQU1zyrd9BWrylj5bNE6MoMBRudvkcbjDU43GeA9aFDVGG7YbpQuCPbSEr+4bEK
iWmccRgj6StEYbTAD08rpM+c/XLlmj16vceLSmXMkLUpfVGJ4a7YXY20IMWegMWT
MozLo5+3f0NbdpJ4YQajm9ly2NyyqZ3ja0D8Rb4B6mlSGdmBJE454eyCUTIrFrmV
ia3KABfEoj9qOEdTWeda04iZZbEZ1PSV7kVf8SIU/Y8FAOlMvOv5N4oMkFzQNQ4R
Y90Lu/RuNHII76gk5/Tk2Y8A/629vad8FtEV9AlenQcLca6nA9MAMqkuLXOtv0nW
OsZDdaQCRZAr9DqYPAK/AWE8hIpvYoqTq2y+w8aYMQJpOBu8V1kePqc1iVC8t/fF
R9xei9dWdYrj//m8kl1F9IvFeVqkmF+iCXdJ1Cuy/KeLqX95IKzuZoXugehfXHI5
Oon/popOEywmdmTZ3qU7LL01Hpg/qS4glIkmwiZwaFKrHAmpLMfuMI4Rr063xQwG
xplEOiDgFtwvPHe24ecbxVT452OzgeBgCMrLongLayfQZ13GGwdxttfYacru8SJ/
G3OvLGfC4A+Jbzi2aAQv
=3tZ3
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--

--===============8771676849984261288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8771676849984261288==--
