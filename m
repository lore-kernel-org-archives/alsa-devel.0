From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 13/18] ASoC: wm8983: Use IS_ENABLED() macro
Date: Wed, 27 Nov 2013 18:20:09 +0000
Message-ID: <20131127182009.GB14725@sirena.org.uk>
References: <1385044736-14911-1-git-send-email-fabio.estevam@freescale.com>
 <1385044736-14911-15-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6970307969919713438=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 83F60265463
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 19:20:11 +0100 (CET)
In-Reply-To: <1385044736-14911-15-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6970307969919713438==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="An7d4yYHBiG6jn3w"
Content-Disposition: inline


--An7d4yYHBiG6jn3w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 21, 2013 at 12:38:51PM -0200, Fabio Estevam wrote:
> Using the IS_ENABLED() macro can make the code shorter and simpler.

Applied, thanks.

--An7d4yYHBiG6jn3w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSljfWAAoJELSic+t+oim9RGUP/1YH46lam6oTc3ZFLTgMKeFo
/HqUVYi3E7Ap8wwdRbmBoqTbZJfYlEo3xLz2OTaf9dNNOeWpdoHSh0LChXcGgb7r
vhEgaAxBSqoZITUSrTjkYwUSkbIgv0L4mm9nNqy5lYy+j1L4UzeXoK8oN2MRER9d
PykYuPqhYHW3K7HKdP0oTQKF31gFPoHCSKaQ3PrvVrYP9uPpwIwIsudVbGUGiNQw
0LWBw7ERCNKhi2YoXqSI3AN9vufyWS0WHfWqUSlsTiJ9try6NOCewGjyQbyVhkou
zUPTEZZZnNjPeFgaMDMV6ufqW+guEQ6rvR3E4slHof0ciUdI5KPLEs+NF78bllOF
dVo6wxVxmdMR5WYQb63Y+q3CJqUUTtvyiHdtmQ9Gm1Cj475ZnJHuEpjeOnuqaqND
r8FCB4hNdXq4cBQwdmuU1pFA8y53tzB5I51SfWov0RXz63EIqzq1y2uhgiq1ODSu
6ffYwHJoqNSWfbPdC1PRaA9o8ZqwHNWVHhVnE5b4acH3AZelTJgjgLART8iTbbnx
z6btKMRigVSUHGWBj7dzsE/pESUWnuK0SRIumsbTLZZeOYu8n6i4GkM5C/eHDxfW
bg7vZkQ6mtoeoRxOTX4/racpRkAtNP8sVRmiCzZP9/euLm4JWMzHsGB2uztjkuKd
U84nSaBm89SOD1aJ6O93
=eARD
-----END PGP SIGNATURE-----

--An7d4yYHBiG6jn3w--

--===============6970307969919713438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6970307969919713438==--
