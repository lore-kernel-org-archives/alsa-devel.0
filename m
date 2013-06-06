From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH V2] ASoC: fsl: add imx-wm8962 machine driver
Date: Thu, 6 Jun 2013 15:13:00 +0100
Message-ID: <20130606141300.GD31367@sirena.org.uk>
References: <1370420501-8410-1-git-send-email-b42378@freescale.com>
 <20130605115544.GX31367@sirena.org.uk>
 <20130606124952.GA19153@MrMyself>
 <CAOMZO5B=OrXUMcD9wYHn=T171usvG_P5dpQ-7iM77-RnS8iSGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1136747544901248377=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAOMZO5B=OrXUMcD9wYHn=T171usvG_P5dpQ-7iM77-RnS8iSGQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============1136747544901248377==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6BJIGhnDLgQ8Wrmm"
Content-Disposition: inline


--6BJIGhnDLgQ8Wrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2013 at 11:02:43AM -0300, Fabio Estevam wrote:

> You could try something like (pass the real clock in the device tree):

> http://permalink.gmane.org/gmane.linux.alsa.devel/107614

> (I will re-post this patch later)

That's exactly what I'm suggesting.

--6BJIGhnDLgQ8Wrmm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRsJjpAAoJELSic+t+oim9ZDUP/i3Qz6Y8GsVPZGr3rtVhwr6h
gmi6Wkj52mfo1jcFAQWQs9w57niGYJ2XGGMzFA2dq+NLzywxhLLo9hMQAVj5hKhA
qKK/FvXtsTvDrcK4aFC5/g+gPRYJGnSOdfBbqq6BDB4upsEa5isTTn3spo4Fd7vA
h1UGlULKLeLaFqPeSsEMRvEJRcSWU+crb/orTVnE+RhOsTzden75xGxvDpZKrq0e
OS88JKsat+cdBUwxzmr1RT1X8Z/oMZWYrjB034yJe+HJDO86tHpsPGGXxSyMGRZp
f9S1HJbVfFK1FIORDXHZDmPBfpK4s5Iukj5BxGLisnrNylB92NZunejiWJSRfwSc
nH2MxyVKmzOm32zRhP9O/lEyn6sUFcI1eKk1jXHgnGr8rkP5u6SNUlVf17PkfCy/
rbGW9Q5RjteO1RYZ8vir0l9iiq9quThAvlC7TvVMTq6anqsHkNAyVUtwPcGXdcJJ
cJ2pxikxKzc7Xxjj/IGGAeBp3F6HgHTbY56tAMHBYnEswKqd5A/Ij2HRvjCnSKRt
tGoXweMb6KtTdbqo7hzKa96Oljd6qcQ0Etnm4X9dfYSW39jH0klYAAbK338qpK7U
hvjpwk8LZMFkmJWakVKg5mCKqpV5CABML0F7xysiQQwOkoo4TGJlxG2DHbfBppbt
+3v2xIRDDKZkDvR3lLW3
=VZMJ
-----END PGP SIGNATURE-----

--6BJIGhnDLgQ8Wrmm--

--===============1136747544901248377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============1136747544901248377==--
