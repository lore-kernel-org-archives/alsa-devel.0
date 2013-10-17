From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: cs42l73: Add platform data
 support for cs42l73 codec
Date: Fri, 18 Oct 2013 00:37:18 +0100
Message-ID: <20131017233718.GX2443@sirena.org.uk>
References: <1382025815-7912-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2942370912800720837=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B8FC1261622
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2013 01:37:20 +0200 (CEST)
In-Reply-To: <1382025815-7912-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2942370912800720837==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5baGGYxPGMjgwtsu"
Content-Disposition: inline


--5baGGYxPGMjgwtsu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2013 at 11:03:33AM -0500, Brian Austin wrote:
> Add support for RST GPIO and Charge Pump Freq in platform data

Applied all, thanks.  The DT changes really should have been sent to the
DT maintainers and the DT list but it looks like a pretty standard
binding so let's not worry.

--5baGGYxPGMjgwtsu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYHSqAAoJELSic+t+oim9LqsP/RIHq9vtzaCA+enBHAfoXwIJ
0tym/b1jXY42St0HEjXTTvDvo6KAEBq3SfPwxGhvFX0nUr0+UEuptpWeTo3H62ZY
Xdv5nht7EXODq3f38OZBolM5thRCjNT7h2N9PW3CeQQLmRobedkJG34mLTgJvY6x
5oHiog0SLJKWAX3XO74hFj1lAtg3Nn5aLt5MAXr9kf0R05flv3YY5yVCmbRRvRKP
/M+P/Li84SHeu1gUrQOYOVaL5drPl3OqjuyGzZJdcwIEnbgoKn/uEwilspVtQn1i
36TuJ4h2RSazPB6BGTXTs3a1QYLp0wwMAbDgDffyIereruyb8+6Bdj2Z5whh2Ow5
tKKY9xMsPrOGvmxsZoHJ68NNbyXwQF6WooX7bdgu1CQT8tlccaKd1lQmYF0x5dRC
Z9HJq7f3cQFhpUHwcfCkpby/AWjQ5skoEUeeWslMGnVnF0ZiGpN/FSdn9nJeup5U
jjTCCOfJ4bdmccZdsXnxH8C4JuTRd+1mwHfuh0zfm/JbVtlAKMwhzbDmNDVxf+U9
4t4wqZKbcTLJpbUBd9IO0bKB4zVJo19w7rAwK4py99mbYxbaulemNwWmh5pi8S7N
i+d+yo0OOLnsiqStzf8kJGiO8Sni2tyZHCJQa8u+XGAOqBaBv92RuWctCibuFhe9
QZoIlosz4eALuMc5TYrY
=4CVj
-----END PGP SIGNATURE-----

--5baGGYxPGMjgwtsu--

--===============2942370912800720837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2942370912800720837==--
