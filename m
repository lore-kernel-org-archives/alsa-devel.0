From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 03/12] ASoC: kirkwood: Remove unused
	drivers
Date: Tue, 29 Jul 2014 20:35:09 +0100
Message-ID: <20140729193509.GK17528@sirena.org.uk>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
 <1405028192-9623-4-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3251478950856147202=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C605F2652F1
 for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2014 21:35:36 +0200 (CEST)
In-Reply-To: <1405028192-9623-4-git-send-email-andrew@lunn.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>, alsa-devel@alsa-project.org, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============3251478950856147202==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U7uHw1LxqiwCht4z"
Content-Disposition: inline


--U7uHw1LxqiwCht4z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 10, 2014 at 11:36:23PM +0200, Andrew Lunn wrote:
> Both kirkwood-openrd and kirkwood-t5325 drivers have been replaced
> with DT based simple-card equivelents. So remove these drivers.

Applied.  Please send patches against current code, I needed to hand
apply this.

--U7uHw1LxqiwCht4z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1/dqAAoJELSic+t+oim9kPkP/iHmjHIDCPp9YDoOIYWJKV5S
chEW7U1ABNaqXfXcyZpFSK3kFzxCAjzp4Bj92agCWEYMF4IvDzAfoM1Q/E7C3p+L
I3MLoon5TZNVUfoCRtIDtec4R7fXeiptSatX6h84wev5Bfob0xCamUwF4RMLnPs7
ZEXd731GUHEEePDru2meGyozfPmpq2lygorFNY62nR9rKil4Z/6/6998pqlqSQz8
NbWss68VIm6cljUxlMUz7aviZdMMTshOhKpZy8XY9aZWeO8zgUt5g0/lrbWVKuKD
+q2DAT+9mb6A4CEnMRR2cBJhywW4jbgr3bVtSKRa0teP1qWotG+OKyHvc1hzJG0H
RWK9IYjTiqUZLhINVNclfRH137GXdaNeJttb6k9hMGm6rm0r8dN4YAFRgfW+FrVz
gC1GJWhvVohg+ldT4WbTe3oS8ntBn8mnlp6XBI3E46iZeZheqDHHSFE0vgdwSig1
WVVgXlEkBczaletUyr+HX2HM3P7/VTDUaEqvSa+INu0tAxCJcXmo2ITks8W2rqEV
smlpUvT53JLzQyEMiIqSXlMe5aLrjQQJJgTxBWW7Lakb9ogxZENjabqe3A/+IPpR
ywM6hKaUxX1JlyGxvqWHiFvGcN5nLsy0satjaHZTapL+0I2uTa8VPB7+JqVIRkFQ
nPcbNa0Gzjm0DmH9fyGD
=6M6T
-----END PGP SIGNATURE-----

--U7uHw1LxqiwCht4z--

--===============3251478950856147202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3251478950856147202==--
