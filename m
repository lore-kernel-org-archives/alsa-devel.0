From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: No sound on ATI IXP with Realtek ALC655 rev0 (MSI Megabook S270)
Date: Mon, 29 Aug 2005 17:34:04 +0200
Message-ID: <200508291734.08197.rene@exactcode.de>
References: <200508291419.34270.rene@exactcode.de> <1125326000.4598.24.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1447830.jTg6BLBV1C";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1125326000.4598.24.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--nextPart1447830.jTg6BLBV1C
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Lee, thanks for your mail.

On Monday 29 August 2005 16:33, Lee Revell wrote:

> > despite enabling all mixel elements and increasing all sliders to the
> > maximum (or to other reasonable values) there is no sound from the
> > internal speakers on an AMD Turion based MSI Megabook with ATI chip and
> > ALC655 rev0.
> >
> > There is a very low output on the headphone jack, but it is really far
> > too low and barely hearable when the Master and PCM slider are set to t=
he
> > maximum.
> >
> > I tried both 2.6.12 and 2.6.13 as well as building 1.0.10rc1 seperatly.
> >
> > Any idea? What kind of debug output would be helpful?
>
> You aren't using the Gnome or KDE mixer are you?
>
> Make sure you try it with alsamixer, and especially check the "External
> Amplifier" control (if you have it).

The console is with me, so I used alsamixer as always. I tried every contro=
l -=20
including external amplifier. Though the later has no effect at all.

Yours,

=2D-=20
Ren=E9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45

--nextPart1447830.jTg6BLBV1C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQBDEyrwQuICExGFvYIRAlFmAJ4lqgB7dwsms/6SSCv1oQpiq6tWIwCY+fct
QX2rXyp+nQLeLXXUjGz61w==
=qcm2
-----END PGP SIGNATURE-----

--nextPart1447830.jTg6BLBV1C--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
