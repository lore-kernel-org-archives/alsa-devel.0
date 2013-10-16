From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/6] ASoC: pcm1681: Include linux/of.h
	header
Date: Wed, 16 Oct 2013 19:00:30 +0100
Message-ID: <20131016180030.GQ2443@sirena.org.uk>
References: <1381492441-31195-1-git-send-email-sachin.kamat@linaro.org>
 <1381492441-31195-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3802590431521854910=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D3332651E6
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 20:00:32 +0200 (CEST)
In-Reply-To: <1381492441-31195-2-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3802590431521854910==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i2+66WLsI1vG03Uq"
Content-Disposition: inline


--i2+66WLsI1vG03Uq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 11, 2013 at 05:23:57PM +0530, Sachin Kamat wrote:
> 'of_match_ptr' is defined in linux/of.h. Include it explicitly.

Applied, thanks.

--i2+66WLsI1vG03Uq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXtQ7AAoJELSic+t+oim9jHwP/1gBd+H8xNlhIyDHr5p5poWO
OCTL/lR56Uji7rZ96OGT5XUrzdPSSmni0NT69d6bJ6IBpAAvgrutd7oXAH9dx2Wa
iEOrWSrAfjtJOuLwG8xtuI/XlFeOLxEtqbedpTjgB/UYAcWMms6w55qO9+aCcsCv
ZvKzWlSDAQi9Q7BdZxDHE/8Q28mBgcE3hf79wMIOlw3LTGwr4CVqR/TbGQHl36vo
cpaxPtNssLg6g67lQDFgsTfBJFFwJGFjk0dNPUTv8uLKawzh144yib/5ywZUpO1w
0U4rKMT4JVCaCthpbdjB+IlHTbuG7zD3VA+HNi8BFzWQHQ5M5sELavHQ6OXzjGU8
A1skBJsmUM0W+SZfqgOwYpGhNHi5iQ1ovCPjxNzsWLEGpqisD/s4v8NU+r2/GMG+
9cmfusWDdQQCrcbprmeLYSMbJbP3lVTUSeajQhAmqdawQPit0iVoFvD4P3fREhAE
/neIjGA30RJODJUhZaYtXokbr39uVX9cmnP3cvqIzMFv1/N57YQyvAtNvZXdoXGA
h5YfdWxgBC5DO7p3+HyzLWYhy90DbjchgNU8lTCnfK3yMrqwK5pCXY2kL95QVszO
2ZH06pPCDRNWoKbZQ7CybeustYqu0zygns73rQrNtHCuxm4MnhqdOli4FGLTcO9A
S2N2U1rRWNfEzE0HXzXr
=2Rjx
-----END PGP SIGNATURE-----

--i2+66WLsI1vG03Uq--

--===============3802590431521854910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3802590431521854910==--
