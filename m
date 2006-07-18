From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] echoaudio, fw_writer
Date: Tue, 18 Jul 2006 23:26:02 +0200
Message-ID: <1153257962.2497.56.camel@johannes.berg>
References: <20060718231935.63c255ea.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1725535731=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060718231935.63c255ea.pochini@shiny.it>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Giuliano Pochini <pochini@shiny.it>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============1725535731==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-UTpWWfPpzCGzzgdjvKO3"


--=-UTpWWfPpzCGzzgdjvKO3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-07-18 at 23:19 +0200, Giuliano Pochini wrote:
> After a talk with Richard Stallman, who said it is not correct to link a
> binary image into a GPL program even if is just dumped onto disk, here yo=
u
> are this patch that makes fw_writer to load and parse the C sources
> containing the images instead of including them at compile time. It suppo=
rts
> both the "sources" that are already part of alsa-firmware and the origina=
l
> files downloadable from the Echoaudio web site.

I dunno where the fw_writer.c comes from, but relicensing it if possible
seems like a saner option ;)

johannes

--=-UTpWWfPpzCGzzgdjvKO3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARL1R6KVg1VMiehFYAQIyyA//Srq5/B8pwSRbwdNMrb+VNST/XdvDB+bD
LUmiDjN3PAwSn3+amNZRWTW6wI1cvhzME/HK+nvAMSzxybOMkN1VHio6p9xo1f3f
BkiNql+pr6oiIsJ51slqa1/lHErlFxYeTvQ/bqPpiMyAffXcy73JOFbOSn7TzRDf
4Ogs2KvOhWS7soJbUFfHBO6dRyFzRyMUaV44feRfzQdLpYflzsYovkId/jXaRdEg
LGYTTVlgH/hOuWxlQSlquR7ML5kSkOrKdvggSql01IFQkJyyAPELZHvzess2Ohzv
J6qpLQ9u5qlPbiCe7E1gtrj9Nf61zVECGBeZ3j7d1yORuMQzykD//OHPB3tW5XlF
4oVc4ajPD1d60zbAFAiBEexKPsxE7zSK+dPS6quV+ByadHy0XUt9+VYGp52AUBHR
zFirE9KTCJPu7npCG+IGHs03vWHUpddXAvBwexm+mb7EET+f3yJeSVI0MDMAzy4V
/t3wslCCxhDtxzrTAmwxvs3a44OIllVMumZhmsugCLpIqsro7bI0Wy5F7BOBETnF
h9HnTcg52ufyk9k+FxwiZSMJ9y3IihPK/8zwHJsv8UM2Ov/RxE77rUIPYzX/mU/E
U6RlX3AGBVIrK1A6LrS1bhEvqzjIvz88ByQefRvzWqQWCjJJUyaBTxxqiIU/ya7z
P6o/gQ4rsG4=
=/QIs
-----END PGP SIGNATURE-----

--=-UTpWWfPpzCGzzgdjvKO3--



--===============1725535731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1725535731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1725535731==--
