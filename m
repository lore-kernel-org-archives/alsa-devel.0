From: Peter Surda <shurdeek@panorama.sth.ac.at>
Subject: minor bug in emu10k1 + toslink
Date: Mon, 11 Mar 2002 19:19:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020311191944.C1214@shurdeek.cb.ac.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

with driver0.9pre10 and 12, the toslink output (alsamixer calls it IEC958
Optical Raw) on my sblive! has reversed mixer settings. I.e. when I set it to
mute, it sends music and when I unmute it, it is silenced. Nothing fatal but
should be imho fixed in long term.

Bye,

Peter Surda (Shurdeek) <shurdeek@panorama.sth.ac.at>, ICQ 10236103, +436505122023

--
Actually, Microsoft is sort of a mixture between the Borg and the Ferengi.

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8jPVAzogxsPZwLzcRAue3AJ9C5rPkabZJ84AQ5uuG7HSwocrsyACffTUa
H8Kjve2R1iBfox7DVTa9fDU=
=/u7I
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
