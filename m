From: "David E. Storey" <dave@tamos.net>
Subject: Re: Problems with HDSP Multiface+CardBus
Date: 12 Jun 2003 14:28:28 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055442508.416.3.camel@localhost>
References: <cd0c7150ee2ca9bc60925c63d149d3a5@essej.net>
	 <3EE8C06B.1090003@klingt.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mJHW/pJ7UfefPlvKgrtz"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EE8C06B.1090003@klingt.org>
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


--=-mJHW/pJ7UfefPlvKgrtz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-06-12 at 14:03, d wrote:
> that's interresting. 32767 has always been fine for me (on headphones=20
> just like on line-outs), and all descriptions about the mixer-matrix say=20
> 32767 means 0db. even sinewaves with 0db are loud but not distorted on=20
> my headphones...

technically, it's unity gain at 32768 and +6db at 65535.

> btw: does anybody have a "complete" description of the possibilities for
> amixer -c 1 cset numid=3DXYZ ???

amixer -c 1 contents

=3D)

d!

--=-mJHW/pJ7UfefPlvKgrtz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+6MZM+5sC2muyxOMRAjZeAJ9tNA0oojLnajCtKb3kmNffJcxxuQCfRgWj
iO4FZ2TsH7fopqg0fDIYgN4=
=YWhq
-----END PGP SIGNATURE-----

--=-mJHW/pJ7UfefPlvKgrtz--



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
