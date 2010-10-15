From: Vasily khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH RESEND v3 1/1] ASoC: Add HP iPAQ H1940
 support
Date: Fri, 15 Oct 2010 10:49:27 +0300
Message-ID: <20101015104927.596c0153@gmail.com>
References: <20100920103813.GD3414@rakim.wolfsonmicro.main>
	<1285573668-5415-1-git-send-email-anarsoul@gmail.com>
	<20100927150609.GB13754@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5497064699761551140=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D1F20103BF0
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 09:51:26 +0200 (CEST)
Received: by ewy9 with SMTP id 9so212693ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2010 00:51:26 -0700 (PDT)
In-Reply-To: <20100927150609.GB13754@opensource.wolfsonmicro.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Ben Dooks <ben-linux@fluff.org>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

--===============5497064699761551140==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/U231WYd7TOqs0RvJ3BjNpVP"; protocol="application/pgp-signature"

--Sig_/U231WYd7TOqs0RvJ3BjNpVP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Sep 2010 08:06:10 -0700
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Mon, Sep 27, 2010 at 10:47:48AM +0300, Vasily Khoruzhick wrote:
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > Tested-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> > ---
> > This patch can be merged upstream now, since dependencies
> > were merged into Ben's tree
>=20
> We need to wait until Ben's tree has been merged into mainline and back
> up into ASoC - probably after/during the next merge window - unless Ben
> has a focused branch with this stuff on it which I can pull.

Dependencies was merged into linux-next tonight, so I suspect this
patch can be merged if you pull from linux-next.

Regards,
Vasily

--Sig_/U231WYd7TOqs0RvJ3BjNpVP
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAky4B4wACgkQRM6pQpltKE5wsACgx1V9PfxyKNy3Nw5HhM+GS9z8
AyEAn1CtwlvCrXQXsD/hJIBMR075Tag1
=DjRu
-----END PGP SIGNATURE-----

--Sig_/U231WYd7TOqs0RvJ3BjNpVP--

--===============5497064699761551140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5497064699761551140==--
