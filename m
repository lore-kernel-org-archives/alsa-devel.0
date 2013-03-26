From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/14] ASoC: ux500_pcm: No need to use
 snd_dmaengine_pcm_set_data()
Date: Tue, 26 Mar 2013 14:16:26 +0000
Message-ID: <20130326141625.GA18316@opensource.wolfsonmicro.com>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
 <1363957934-20059-8-git-send-email-lars@metafoo.de>
 <514C7230.5070408@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4794867849734338353=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0F7E1265096
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 15:16:28 +0100 (CET)
In-Reply-To: <514C7230.5070408@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4794867849734338353==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HSVPcR81XVhxeM7P"
Content-Disposition: inline


--HSVPcR81XVhxeM7P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2013 at 04:01:04PM +0100, Ola Lilja wrote:
> Acked.
>=20
> Regards,
> Ola

Don't top post and it's helpful to write out the ack fully so tools
work well with it (things like patchwork for example, or cut'n'paste in
my case).

--HSVPcR81XVhxeM7P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRUa2zAAoJELSic+t+oim9JkcP/i245ST9qlR+hD5ACngiKfc8
kaISpM31FpxvQ1+RM+Csk7WzfCgSKYvKiK5KLFXPziK6qz3c9iwCgUMy4thdfPl8
cQuxunDuQ3npS12afuyq4cxiY29c6vqz6SwQ0xYFxAH4ckrBOrjIyT6ihceF7Zuu
ktKs0HfwGmP0EaVRNv917V4Dio4ssdTsmANXC8vm9KSjhYvOXTgyvTxcrScP4GhA
KA5pTAdFpqK+gW5XRaGxljv5SMfNc6Km9vXrDLt8CHDC/OmkzpIqPscXs2vNl7Vt
O5nu+rfrekumAliz9Cz2U6n2ymziiGcOrJeN+q3siqk4IqxMmqFS02AKkw4l62Bp
LinLJmqFMfy+znyecAv0LivbLjQx6VL23cuEbgaBdmQJ08roAj5R6IejJNIahVlP
1SFsJolquz0B9knA4MszKahgbsrJTqwNI+SdYrX3z5jeCEOhYuUb518qq6l5PPPv
MHgJQWG1vUyaCnLc0w/19S45R3wn5ngm5ajzj+ioBJKSmzXjsmZ8racxnPZKcV6d
KUArfzxwiKJjvs5gKVraLPjDcwhBkEbdlkmABMRc34tDOokwQBJuk0gkOYQkQpDc
n8q+TGbrpJpmK/7XwsqigJ/TcCqxy2O3XUMoFPkRuGYfbh5BzK9tHXSe3KCcQsqj
vT8MFn5FrZBUKpfaER6u
=Gejg
-----END PGP SIGNATURE-----

--HSVPcR81XVhxeM7P--

--===============4794867849734338353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4794867849734338353==--
