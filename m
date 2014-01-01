From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: Add device's module
 clock selection.
Date: Wed, 1 Jan 2014 12:25:54 +0000
Message-ID: <20140101122554.GN31886@sirena.org.uk>
References: <1387783538-5318-1-git-send-email-Li.Xiubo@freescale.com>
 <52C405DD.1080006@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8199160209398238868=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9304C2608D7
 for <alsa-devel@alsa-project.org>; Wed,  1 Jan 2014 13:26:04 +0100 (CET)
In-Reply-To: <52C405DD.1080006@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============8199160209398238868==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4aWqK7AGBdpHaKKF"
Content-Disposition: inline


--4aWqK7AGBdpHaKKF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 01, 2014 at 01:11:09PM +0100, Lars-Peter Clausen wrote:
> On 12/23/2013 08:25 AM, Xiubo Li wrote:
> > diff --git a/a.out b/a.out
> > new file mode 100644
> > index 0000000..e69de29

> This patch did add a empty a.out file in the toplevel folder.

Removed now.  This is one of several patches from Xiubo that have done
this - Xiubo, please check this.

--4aWqK7AGBdpHaKKF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSxAlOAAoJELSic+t+oim96FsP/jKspI5xbfw4SeHn0CQng7xV
+CkxyTIrXExMf8+RAgwx072GtDXvvDNd2CPm0tlz70FzMeEjxqTAe54pjrQNhrks
KvHiiuUB6Eziqj63uZj5ODcPjhORTtFW5Lhg7aYI/IhXwCWh8+xe6YwRXk0/z7lk
RNRS0a4fxnr6HRXnk/58Mz2WYuVMDSPC0nuqYZfMpjJIimNhkNg+ivSko5fhXxUq
sjH/NBrDJmGvK1Fik8hmt/xad8D4w20mSxFY2F9O7LNlceuWeub10I+0cz6RPp3R
GxrFocmG5GGYKEr9Yfp8xDT+shFn5vu4D5qdzuerFURoj8z+NrxjblqWV7aHPFV7
JEZ2VilvXlOf5Bqy9dpmlDShHbBOAAaVZ7CP+vsGB0oQpDfBL2uY0YAwNpvXVrUN
wj+X3m83hpamzwJRv8P1YfYt6M4QeiM0y9xeos8AQ1ZXlBym/XxVWBp0iwPv04O1
pCD2KmVaoFovc4+58vfQgFVIWKgx8fiWMAXhcPlXgQVa/EG8CTcaf8GfJ0Ot1ySK
UZnwFW05M3MXGnfbp9ceJ3IVnmOsmKE5RGXCLLUUyRDL+dALPBjaiwm5Djbe6Mly
nx8n/pHy6LwgLAOLSOBsU6zvIGoOrH1vykw4DNxaVDWTaCBuMFM3yZ8RjXNE+s2C
AUzt4YZPU5x4NOn3xUaW
=gfTP
-----END PGP SIGNATURE-----

--4aWqK7AGBdpHaKKF--

--===============8199160209398238868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8199160209398238868==--
