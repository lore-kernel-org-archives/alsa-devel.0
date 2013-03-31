From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2] ASoC: Implement mixer control sharing
Date: Sun, 31 Mar 2013 19:00:49 +0100
Message-ID: <20130331180048.GP18316@opensource.wolfsonmicro.com>
References: <1364593210-2373-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5771851759287442657=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9811F2625D2
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 20:08:34 +0200 (CEST)
In-Reply-To: <1364593210-2373-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5771851759287442657==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u8zu0/Xp8RxpBt3B"
Content-Disposition: inline


--u8zu0/Xp8RxpBt3B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2013 at 03:40:10PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> This is the equivalent of commit af46800 "ASoC: Implement mux control
> sharing", but applied to mixers instead of muxes.

Applied, thanks.

--u8zu0/Xp8RxpBt3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRWHnHAAoJELSic+t+oim9ou8P/jZG6aRLWK1nsknlUZYnV8K/
tBCkg+/XX5W0u26ZavvkrJ/n4CI/z/QsXK1+qhEV9C3IIz7LR15VE1l6i1Ze1/ZV
pZZQpnQIYFi+Jj2uC6fcQ8R84vX1EQbqwlhQQu+jicLYygnk0B0xHsSNzOb9X9jd
Ue9in3aiKEGEvTHYOfbMvwGwJSNq2cU18thP5IS8ugt9qW/jjbzsXo+8Hpd0VV+w
tc+ZEBnlaEPxfp/+IfuGzQQvUTdfKkh78szKD5l3gadsghLkszOFfkt4QwtzFZGa
TMXDui5Gm2JzPeAiZLAvmUtuJ//PIbWZ8CUEB2kcVRxPH9Y3xrPXiLRdvw7/6iFY
5hPApWyke3f1GG5T0qzl5R58dlqo3KzMNiS2BOliH5MA/3wrz6/8tq7LQOb6IK2v
d0PjuxoCr9D4pIRwTRionLHSUU1SP6Fr5gTUjRkFDI967sDLPWZJ2VtMKXVvUrjw
4tr/alSc7YmK6JV6C4MhLVUNNG1hQdhArP32JGNTEYNnmX7Lo+ppL0s9pmIT7Rs3
Cmke8Q8NxqqZ/ZHuaUdEy+mJws5nS32v2xmbeV7fst6u0JO7tVOEAzthO+USwtX7
kYVIst9Y9DemmaNnyUWcpY7E6B0AQC0Id1jNUijI0kLL6z+Eiu+c/xdTvBdfXdvk
0aYdh6/HKBcFzMjYsQYs
=VG7P
-----END PGP SIGNATURE-----

--u8zu0/Xp8RxpBt3B--

--===============5771851759287442657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5771851759287442657==--
