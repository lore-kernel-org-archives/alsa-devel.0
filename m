From: "David E. Storey" <dave@tamos.net>
Subject: Re: Getting actual sample rate
Date: 11 Jun 2003 21:06:55 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055380015.434.8.camel@localhost>
References: <Pine.LNX.4.44.0306111446550.1142-100000@home.aussec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BePHP8OClKFgXUjJo4aH"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306111446550.1142-100000@home.aussec.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-BePHP8OClKFgXUjJo4aH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Anyone care to shed the light on the math for what totalmix does
regarding fader-to-mixer, fader-to-db and mixer-to-fader values? What I
have works, but it's UGLY. (well just the constants... I like things to
be simple.)

d!

On Wed, 2003-06-11 at 00:48, tom burkart wrote:
> Today, Paul Davis wrote:
>=20
> > thomas' code contains the results of the communications i had with RME
> > about this. it was unclear if the conversions should go into the
> > driver or not.
> I had a similar issue with a driver that is about to be published and I
> decided that userspace can do that one...


--=-BePHP8OClKFgXUjJo4aH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+59Iv+5sC2muyxOMRAgmxAJ4+KtnFVZsJSR3ULzrmrPklPFWx/QCeI1ST
4goEcSsaGU5E0GYVEkk64dA=
=zYyV
-----END PGP SIGNATURE-----

--=-BePHP8OClKFgXUjJo4aH--



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
