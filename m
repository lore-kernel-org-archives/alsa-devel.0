From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 01/12] snd-powermac: no
	longer	handle	anything with a layout-id property
Date: Tue, 27 Jun 2006 19:40:18 +0200
Message-ID: <1151430018.597.25.camel@localhost>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de> <s5hac7yvfhe.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1521086786=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 97B3426F
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jun 2006 19:40:27 +0200 (MEST)
In-Reply-To: <s5hac7yvfhe.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Andreas Schwab <schwab@suse.de>, alsa-devel@alsa-project.org, netstar@gatheringofgray.com, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============1521086786==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/tV7irgxwbmlL62FX0CB"


--=-/tV7irgxwbmlL62FX0CB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-06-27 at 16:29 +0200, Takashi Iwai wrote:

> What functions are missing?

I think Andreas is referring to the fact that the device-trees on
PowerMac7,2 and 7,3 are broken and hence snd-aoa-i2sbus doesn't work
properly.

johannes

--=-/tV7irgxwbmlL62FX0CB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARKFtgKVg1VMiehFYAQKSXg/9Ef0JSA8ehuKA0c5Rjc3DwB3l4XPB1WV1
7nJTQu3LkpVBueKfdt45LMxVuFGeXsgeFEEualEbx/K8QRApZqrvDylub2SKL07D
lee6BOkWVKEpPFFeWpJarm4arB+yZ3zpUJyfRAKQW99tMFzdQl006JWIRX773ATP
ZaJx+E3/F3tPFEO/WZMYCfXAi1sZjQ1jipCxcugB/fVjDQ5BNjzGGYboxhHMbw6p
B/NuMck4CdvIAsUAniKEqa6Ch6M2jWcg1tjC8xCbsG53sGeFlcHFHqDyjrw2EPn9
5bAzeIe6f/uE0jqQXIW+ynzkNfTWCoNssnfrPr7jD6q0rc2gFF0rlqCTWew04ezI
bA3nQb1evOAtfw0CaxLQydXNf3YhDPkjPAzXVUQS3uXlXhjb20mjLordpgo5xxxC
mIzAvCaLAifCE5YrGG8YIjz/ZCH3Yat6OpMTANZpMV7DR/ZRUZjkzS3Kd+mPZ5BU
Ljfaa+Up7b0QZzm08YnzA6Aar1e1S/aQ2QllgwpPYZPizqtz6IwEKWGlUoLfSrsV
ahkVvVZhW9IxCNphJcw/C3ljQs3cqwe0jvyOQLQMvLA/BYIHgh2cp2oBYmeienSc
QjkQo4N8HyNKPITlP85PXCLNbfJIxQkjkwQZ/XPUexGItHHPxII8KPebdUxoS44f
8AgX9OBjVWQ=
=s1L3
-----END PGP SIGNATURE-----

--=-/tV7irgxwbmlL62FX0CB--



--===============1521086786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1521086786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1521086786==--
