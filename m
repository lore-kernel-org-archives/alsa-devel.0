From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: omap-twl4030: Use
	devm_snd_soc_register_card
Date: Thu, 19 Sep 2013 14:58:15 +0100
Message-ID: <20130919135815.GW21013@sirena.org.uk>
References: <1379391839-8016-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3975752403555376094=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F03926546F
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 15:58:35 +0200 (CEST)
In-Reply-To: <1379391839-8016-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, jarkko.nikula@bitmer.com
List-Id: alsa-devel@alsa-project.org


--===============3975752403555376094==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UaIp6+ubhcbWp687"
Content-Disposition: inline


--UaIp6+ubhcbWp687
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2013 at 09:53:59AM +0530, Sachin Kamat wrote:
> devm_snd_soc_register_card makes code simpler.

Applied, thanks.

--UaIp6+ubhcbWp687
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOwL0AAoJELSic+t+oim9W5kP/3fGOqJCfgfo+3JzKIdynv1X
cM5YDQ7lFJ0bUSS8mNCYWn/+oABk74Sx5Edm7evtbNoma/ceYNg+47c+faoKa7vy
YoQ3TPhrF0XaoH/ELCtxdPV3AVOT+BzkrgBkRNI5OkUzKJsFTT8ftFcxNkShlIzl
0hIJ7PDqNVVPQ9TIpOj1TIz7MVcEBErkIzEDLYTm7vDnB+2gc624nokAN6/y/x+s
H3iuvWBycBPgp1MNVi2CTvYz3fma+30pIFqEYs6gknDY7D3+GvbIo55VZSbsJf9g
hJXx7H/HLEeA5mZZRtIp7gEhsq7ELI56gAWGf1jgPhodizYOQ3BCvyt5DCXmETKL
N98mxteKYRKqFqqNfyWH0DiPB7Cq7CkPkirfExQq3BmqwgwRSA5gfqAGq4h0wLKH
dxPmYxShqdZ+wLNNaYevEAngq3Jl3VA7tvsePVSIbYyurnPl7Z1wRdTtIjjE8As0
TbVvycQfyiHBLtY0R3Od92YA7wwZeccN0X/E5yu0L38+VwKag2TdcriEI7vfMgqt
EMXu2Wnnw4t6lHKqDW6AGwAD7GYI0hRvovN8kgOaL6aAOp15+kddwrjmoqXxxOGD
XwWBlMB0yiPoVGqDElXTsufjfE0Yc+YrCB5Mkyu9UtM07cx26uVK6E1PgRcePpRY
64+vdaBOVgUpaUbsFXeI
=RNXp
-----END PGP SIGNATURE-----

--UaIp6+ubhcbWp687--

--===============3975752403555376094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3975752403555376094==--
