From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 11/13] ASoC: spdif_transceiver: add
	output pin widget
Date: Mon, 5 Aug 2013 12:33:02 +0100
Message-ID: <20130805113302.GZ9858@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V6428-0004lz-Gw@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4326876958627544990=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ABED2615DA
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 13:33:06 +0200 (CEST)
In-Reply-To: <E1V6428-0004lz-Gw@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4326876958627544990==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfeyO7WMIY3cokGy"
Content-Disposition: inline


--WfeyO7WMIY3cokGy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 04, 2013 at 08:32:04PM +0100, Russell King wrote:
> Codecs without any outputs now remain powered down, which means any
> paths to these codecs also remain powered down.

Applied, thanks.

--WfeyO7WMIY3cokGy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/41rAAoJELSic+t+oim9ESMP/0CxzDBMhykWZQ71+pEkaWKY
znHl1szuOdutGxZqhYiL7qLMdLjjsv+R0Am1qInA8RgvhYRQOq9uI4nvslz3g1O8
NllbLL86gZhHcjSzTu55nBO9mSEq+3/vHvcX1PH46jHT4QT7bAfO5ZS1jMHTt5X2
dfWuZwYJe9aoFmzU4RCeig8XOe5ny0+CgXDj9FnqBjRAZ1TVwDU33awvghYTE0OM
AQg4yiiRtZmbAPd++CKcFm14nxoPqv/RQBy1hkoPXP/NTxTGPZ5YKjNZJlK9oboI
/ZaaQ8dr6UJmsxOBi7mlC3pkFW4dcOnQS7JQs8VrDDqOHUAhu1a3CPwihnGUnqKw
3fFYBskFfgk0Belm17bQ9mw97A4dVNcMRxkH6P3qpFV9LA+mkVHfVmKRaNqk690W
ou5IQuxuqltF0AEZikNIs6w0qMQvGJ3UWEfYaFJozxJPSenITVue8KjFOZmb304k
s0wRkRdd8RK0VmWV5t1X08TD4BS1mrriqsTybTGXC6pxF4fcn5dbgtV2vCcWuCnl
1K++Mxb5E2gOKEosxZvVHozu8X9nKeiyUe3ydI5P9EhsI18tf9SXNFUbfYBFY7PP
/Y2mQ/GI2b0l6+IBJr8qeg5/cGwRCoC2djcBCHb4yFvT+og7jqUea+MuGmqr6NtD
dAooKBPhJ3MSYcY3PX0b
=eLDY
-----END PGP SIGNATURE-----

--WfeyO7WMIY3cokGy--

--===============4326876958627544990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4326876958627544990==--
