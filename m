From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: Problem with underrun on new CS42448 x2 driver
Date: Fri, 27 Aug 2010 19:00:30 -0400
Message-ID: <201008271900.32511.vapier@gentoo.org>
References: <AANLkTi=3kc74QqDopiAw+u8ie2Qn47p9XQpw54b6iB4Z@mail.gmail.com>
	<AANLkTinVdY6qsuBMngOsnXrm=chfqkwJAn8msJtnyt_=@mail.gmail.com>
	<20100827212019.GA7399@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7375351635188031579=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id A599D1038BE
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Aug 2010 01:01:24 +0200 (CEST)
In-Reply-To: <20100827212019.GA7399@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Adam Rosenberg <adam@alcorn.com>, alsa-devel@alsa-project.org, Sonic Zhang <Sonic.Zhang@analog.com>, Barry Song <21cnbao@gmail.com>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

--===============7375351635188031579==
Content-Type: multipart/signed;
  boundary="nextPart2393407.HRXRJxI8nD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2393407.HRXRJxI8nD
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday, August 27, 2010 17:20:25 Mark Brown wrote:
> On Fri, Aug 27, 2010 at 04:37:45PM -0400, Mike Frysinger wrote:
> > On Thu, Aug 26, 2010 at 14:06, Adam Rosenberg wrote:
> > > Thank you for the reply.  I emailed Barry Song on July 30th to request
> > > some help moving to the new ASoC standards but received no response.
> >=20
> > developers shouldnt be e-mailed directly ... it isnt uncommon for them
> > to simply be punted.  this is why we have mailing lists and forums.
>=20
> That's shouldn't *only* be e-mailed directly (for Linux stuff).  You
> should generally keep the relevant folks in the CC as well but also mail
> the lists concerned.  The direct mail is there because the lists can be
> high volume so it helps people see the mail, while the lists mean that
> people other than those you thought of will be able to help and that any
> answers will be archived for other people who might need them.

right of course.  i meant e-mailing people directly and not including lists.

for Blackfin issues, we have a mailing list that should always be CC-ed=20
whenever the Blackfin is involved.
=2Dmike

--nextPart2393407.HRXRJxI8nD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJMeEOQAAoJEEFjO5/oN/WBhX4P/jg9fAXcHLEE/aCxpyFIYXIj
N43cylZPjo0LzumrEQToC3MeADTkoO6yGFn3x/X/3YBh1/M3bpWIF2DiRK5aJAdR
H+wwSeve10ZQyN1MDuunYK4y7JMSRz+pOG/30mD2nxp2O0DmJN9H+zz612X+j/Kk
HnRPR0zMhrBY12qZ/yolB0hNkA/fxujVlotnn4JLCzeTm1/2Tq7jNyzuMn5G8qPk
O1hEEprnCwQIsQie5S1+HE8N/bIGi/3Rp6TLK2RtvV9GwzreiOyvWJZy8yDQYEiy
LBMMFplWEWk+FvJUdUW6ckxA7JmM9MNyVtPXlao2lleKV/ruV7kuFg9GX4zKQr1X
X+lSqperHqIoqk2XNvD7h7YXhPhNaaYolk4RqjEaRQIuUiDocxWMdDNOX/8bD0Qk
yyKzg79YBlSPnBoNh3y0pOVs4Ri1DRVrEzCW/Twmu/41OXpKgBONVMwmDst3Cg1l
QjYw520TimM2LEZWz/rMQf8+9PNvMh4YJMV625W+KHJ57XUsEYa2qJp6FVdfsP1n
N9kH3olI5vJ8MqoN1/ypJ1nMNlfdgMdsrbC/rJ4OMOwX9OJAgeHU+VxnSu2nIgaw
C/26gX38PvKIHDweD6VFSwsmJy4qpysChRs1FRlSaZzZvQMJeNc/RNXtsNmf+B2w
1teo7QVFMY9qvD4/cMLu
=yfVl
-----END PGP SIGNATURE-----

--nextPart2393407.HRXRJxI8nD--

--===============7375351635188031579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7375351635188031579==--
