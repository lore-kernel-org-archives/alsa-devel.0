From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: mc13783: Remove embedded
 snd_soc_codec structs from private data structs
Date: Tue, 6 Aug 2013 12:42:51 +0100
Message-ID: <20130806114251.GB29078@sirena.org.uk>
References: <1375789171-12098-1-git-send-email-lars@metafoo.de>
 <1375789171-12098-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2129146715020284817=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B23B626545B
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 13:42:54 +0200 (CEST)
In-Reply-To: <1375789171-12098-3-git-send-email-lars@metafoo.de>
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
Cc: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2129146715020284817==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2013 at 01:39:31PM +0200, Lars-Peter Clausen wrote:
> It is unused and a leftover of the pre multi-component era.

Applied, thanks.

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAOE4AAoJELSic+t+oim9Gm8P/i3A56Fi/ZFqqlGsr2yHp1ts
BcjpWG64ZsyrSR9VKK6ZgBrfoziOMlUynKxB+EQyewNhVABDVvfC6XzyiSL3YT3c
bDMJEJEmbeR7eOzOx+9SDelIGG9mf1/ukjWVUZlS4dVAMuvA5gAVRN8Pip/eXDRG
P/U3Ah8XlcOCbQxcJizYKd+Vw00KLzTMk2bTqBNN54nHg1LOMzSfJ2cgHLRJOqJo
40o2/IEiAfEbNiLppEqB77/h9hcNmYymka4PFEZr2lfjWYnJadthRUxhtY/dZhs4
4a9XlfHUhMYhFK70+6OsazjjR1SyCPDzaaWH9Kw9MLekR/x2yV9638rF5kbMPOR2
FJGdywWH+3qCbs9PWFM1EHNRa/7gJR4fFlU2JRXsnVPbBVp2KD0g2DU/JBGbUBL7
6UKG0oc7trBhMaLkYn2ZzmTBa5YxGyzehIMhOdQ1UteHL1tZ3LfYpIwmeZKot/Fh
+vmfjXWGO3gRfSz6rL6GGN5K7ZRwkDv55x5jjdYQasPlFuIdY5SnmeeHshg5WGGD
SO9zfODrhx1ZXW0EYIkhVR7J1EVl0zOMuWsgOLUglhtLarLr0KqIXl7GKNHTR2Yy
kvZyLrVT2TfoouiKUOIKHXmDwj8vVtEfsR4g9vRGeHqQuE/nOU+Q26M3YGoA1Old
R20EU+fAb1DPMXS+BP7j
=0sIi
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--

--===============2129146715020284817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2129146715020284817==--
