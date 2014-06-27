From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/16] ASoC: cs42l73: Remove redundant OOM
	message
Date: Fri, 27 Jun 2014 12:48:41 +0100
Message-ID: <20140627114841.GJ23300@sirena.org.uk>
References: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
 <1403258352-8210-2-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6612786112825010077=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A583265152
 for <alsa-devel@alsa-project.org>; Fri, 27 Jun 2014 13:49:02 +0200 (CEST)
In-Reply-To: <1403258352-8210-2-git-send-email-sachin.kamat@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@samsung.com>
Cc: alsa-devel@alsa-project.org, spk.linux@gmail.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6612786112825010077==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kTN++mu+z+U/mv0o"
Content-Disposition: inline


--kTN++mu+z+U/mv0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 20, 2014 at 03:28:58PM +0530, Sachin Kamat wrote:
> Let memory subsystem handle the error logging.

Applied all, thanks.

--kTN++mu+z+U/mv0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTrVoWAAoJELSic+t+oim9okQP/idJEvIVWaTYebcN8wn+r1LC
Olo6OvJ50EjJAIW/1q150RdIlIUSz/BP8tVVi94GCrFogo3J9a6hjrmvIsnKJ+Vd
ZIR+Si+L4rtE1hlhk+xgFY/3hwAOyRxUDXxAHo1m7nKPHITnZ5rMt19JrzaZMjmr
NjV9MkPWBWbDClghMZyYVVnl4K4JHFgFQ2k3VWkP4KCBqah2EckA5UtTUbOMisiX
5jVU70WSk9czNk0Le+J+jY9MO17OpqLmTk3Qv24NeNim+A2582HbnRY1vIeEeIUL
B0D52ge3k7+YO+l+ee0nc2UeJkoy81CIaJm+U7GSjmvYGFjFOvU6UIEE21WyzSxT
ZUtMbjXzWdg+FlFHJrZHza/CfYTACS6e5yui4+ay2jx+bvGfFe32KOX0uRSIG1+z
4yfFk0JaBDqaY0JVjjtpZUHgG1n8qBQHG7Cl2ISOyBhwYJuh2tWSBp2g52uWqSUW
zKlVdR3wRwyGdjp9oLYQWLj847X0xT/0jiH8QVR7WWBsDCTq0LdfoQ4lL40EX4iG
JXw4Gdn3ppATDGLn8IpO/ejyoV132jGxtKw34VVa3//qZ1Uyvt8/lF/qJ1Cf1rG7
tkyGRlRUAIpBOhsmVjHdglVbXgd1avMX3PBXIKO2296IiWozXiKlmLDowDK1sWVR
RIVEK+fNrYOgSKnBlWvF
=sT6r
-----END PGP SIGNATURE-----

--kTN++mu+z+U/mv0o--

--===============6612786112825010077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6612786112825010077==--
