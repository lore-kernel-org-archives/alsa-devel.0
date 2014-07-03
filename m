From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: twl4030: Remove unused variable
Date: Thu, 3 Jul 2014 19:46:48 +0100
Message-ID: <20140703184648.GR410@sirena.org.uk>
References: <1404188973-1857-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0635042108355348288=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B293F261A74
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 20:47:02 +0200 (CEST)
In-Reply-To: <1404188973-1857-1-git-send-email-sachin.kamat@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@samsung.com>
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, spk.linux@gmail.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0635042108355348288==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3M+s3upKwjqB7kL8"
Content-Disposition: inline


--3M+s3upKwjqB7kL8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 01, 2014 at 09:59:31AM +0530, Sachin Kamat wrote:
> 'status' is not used in the function. Remove it.

Applied all, thanks.  Please remember to CC driver maintainers as well
as subsystem maintainers.

--3M+s3upKwjqB7kL8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtaUVAAoJELSic+t+oim9dpsP/iIrJAOQB0DM+pPLiiq3pKnM
l6DrLPrQYldY//E0bH0AwpfZ79oscjPIwSsuVOn0C93/gjoPji0iWWXkkC80mSUo
4skEwJDIHXz77eW9EnfKYiUl7nG8m828C2Z0WYnakCzwZIphSN+sR10EUeo/N1FN
Puq+xsv3Ww5MNISPoN9lpSY2jkuQdZPh/r5cqpfDHuqi5bvUeljqZgqa4T18iUqp
BmgBjkVdh/b8ngl82CCW5fCoUUNp8Xmx3LbnC5S+z+nwk+ttfP64qYY3PX5Ih3uX
2KpU6gIvbYomcnyxUw7ZX31ijstatDNRp3ySXVt7Zl39R9RUfpQkVCc+GqSoUtNR
PRiwhy77/iw32GLSPvq0NBlcmOjrmlMHyp2OW7cAXj1/TZAj8vK9tLk5a30oqsH9
22Qnr/YEkOq6fXkY/XohAubYabUVEKZSHTejnHe2TjgO1Hq2YCMA4mlcpORSmM9p
9wPQiPPEzptAPBWzM4dkWBVwhtQQdiNdLOi9ZD/Jw7AJfITqTRL9WGlC0nnJqhJc
pDn9MgLudkoS9ay4xHZV1nQ+7loD6w5M6CKTFs7YE8yuH+uBIp6V2JS+p8f6gWe0
B9kyl9VtZhhsnJuD9VvuDrrSGVEndHuFrrKdMP+rVekINH0vwpvG+txCgh9ETmKl
/aR/lyzkmYaqjRUDo6pE
=Xac3
-----END PGP SIGNATURE-----

--3M+s3upKwjqB7kL8--

--===============0635042108355348288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0635042108355348288==--
