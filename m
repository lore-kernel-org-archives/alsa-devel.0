From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ASoC: bf5xx-ad1836: convert to use
 snd_soc_register_card
Date: Fri, 17 Aug 2012 23:26:45 +0100
Message-ID: <20120817222645.GG18871@opensource.wolfsonmicro.com>
References: <1344636369-12367-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1716354497252359117=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 562EA266189
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2012 23:57:06 +0200 (CEST)
In-Reply-To: <1344636369-12367-1-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1716354497252359117==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 10, 2012 at 06:06:08PM -0400, Scott Jiang wrote:
> Cpu dai and codec name are passed in through platform data.

Applied both, thanks.

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLsT1AAoJEFJkBDiqVpZ4rIUP/0FzDRvHWtKpGSlwGIH/odPe
/qjhT9tw3Y5zFu/HpPEacTZZVwgReIBSxf1x+Kn8EhVMqR2V4+pINjlwI1j29O+M
zC8tH1Aj3Uae0MGN6LSLDFJHhZ17+UdiuqZVJHodlwRMXWmXub+Mi9KnhiNbEW4o
dDBAVMpjER4N7Qd85Ru1psAlBAX8TuDP+AJ6QX8a44VHF0D0J8c+4CTH82I3TmIs
joMahrKjFOUjSSqPYi+CQRP60Nx+WAnl1EBIX0HG9mFEdVWfMSQ+7wulYZqHPsnV
EvmWbjZHhTdSxccYZIKOuAoWGjkS+G/Bwqi+7jCxv4wLXpRAY+HZgG7yFBVPoURg
WiEl8eVwx5ACBxFCiDvXLKu45pFTwHKQcbNSRb/rhjoYLslt0ZGiYctISFTfAiQg
/Mk21x7gKv68JBGcBcS10FVBk9v0yUkfC7oX4m5eKi5tNMXqGVOrcFibPgJQJLvF
Sxtl1hnjALj6hVlxsLN53SPJIgCoK66tV6AmwcigE+FOTR1r/Mh0H7rSehSV1QHT
AUfYUCrit08yJB3iy0pBteA3oD+jvm3j3IQsMNvtrb36ZUIeLIqJdT/lxbpQRUjq
yUVGOojerRfjzc+hxx05muttDo+Vdd2Ygaum890lYwqTAwhFpHKyuU+/JrwY+x13
dHGJsPPM4b1xtvNS6Swk
=mrPw
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--

--===============1716354497252359117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1716354497252359117==--
