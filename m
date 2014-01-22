From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: Samsung: h1940_uda1380: Remove
	unused variable
Date: Wed, 22 Jan 2014 17:12:10 +0000
Message-ID: <20140122171210.GK17314@sirena.org.uk>
References: <1390392043-24387-1-git-send-email-sachin.kamat@linaro.org>
 <1390392043-24387-4-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2295618763700423648=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 009A52610B5
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 18:12:19 +0100 (CET)
In-Reply-To: <1390392043-24387-4-git-send-email-sachin.kamat@linaro.org>
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
Cc: sbkim73@samsung.com, tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============2295618763700423648==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oKgpfCkFlWVMWpTW"
Content-Disposition: inline


--oKgpfCkFlWVMWpTW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2014 at 05:30:40PM +0530, Sachin Kamat wrote:
> Fixes the following warning:
> sound/soc/samsung/h1940_uda1380.c:183:6: warning: unused variable =E2=80=
=98err=E2=80=99 [-Wunused-variable]

Applied, thanks.

--oKgpfCkFlWVMWpTW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3/vnAAoJELSic+t+oim9u0AP/R4YpBWcbAQbz6LivgnIbL0x
xqDpa2vnm3BJ0Ei0gUTcOXAi7Gq7coNlc0tf9mpW2EQ+xEZryOJZuseJ4c325odv
cgjMYWIDZtyHR7VFkB/a3fGZXl2meLdgaBAAL6M29QMhJbRryuEIbK3XlTYAu6MV
nmyV0w/mN14lw530pj67X29aQEHbP82bjFDhR+cubEB9TCJJlP8aWautbYsVPYgK
cfVme9qb5G0VlnAPguKpCQRbYwO9KiAEfgqpa3j5v3ZAtyqd5Sjx1F+fzLGoj7XF
9duncywMqakPylgW9hkD3mnZhlxOEX50GqaV0Tuj1/dwJJudZsrdh4JubyVkhvre
iwsiRI+VPQQMK1QDfQViTEf1OBWjjtpuYc47BAjJeTTAEaAgaweC6z+z7Z3VF+JP
0AU28TggWsPOhvSSsXSoH6IUFMcEOvjZB7BxgIs0mbF9867x/CAt4uDrE/RUj1tF
J1ErRzsPaGzguYSogsp9bJ6w8zkR1j8k7guc5sL6iB6AnPSUUdtwzGdA63VuDOOE
npH0wOIAu1LmsEXCCRjDXsSUwQreQSWEXqfciSzXs6XnJHXNZh+8dvVH/xS4KG4Y
5qPbde6Dlw6oRwi6/7rhiswQHZvh4g8Tl0Tnusc1K9dkutKV0QONrEeH3CtUwZY2
g91ue7G9P+b9qff7Emk7
=9ZcO
-----END PGP SIGNATURE-----

--oKgpfCkFlWVMWpTW--

--===============2295618763700423648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2295618763700423648==--
