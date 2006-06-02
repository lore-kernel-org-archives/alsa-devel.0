From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 3/8] snd-aoa: add soundbus
Date: Fri, 02 Jun 2006 16:44:19 +0200
Message-ID: <1149259459.11092.28.camel@johannes.berg>
References: <20060601115844.343214000@sipsolutions.net>
	<20060601115846.852128000@sipsolutions.net>
	<s5hu0734qay.wl%tiwai@suse.de>
	<1149257225.11092.22.camel@johannes.berg>
	<s5hslmn4p00.wl%tiwai@suse.de> <jeu073aad1.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0766448476=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E6A03156
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Jun 2006 16:44:25 +0200 (MEST)
In-Reply-To: <jeu073aad1.fsf@sykes.suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andreas Schwab <schwab@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0766448476==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-wc9U1Ndo4DwKjqD3r9di"


--=-wc9U1Ndo4DwKjqD3r9di
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-02 at 16:41 +0200, Andreas Schwab wrote:

> If modalias is not nul-terminated then strlen will already fail.

Yeah, I'll just have to make sure elsewhere that it is.

johannes

--=-wc9U1Ndo4DwKjqD3r9di
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIBOwaVg1VMiehFYAQJVpBAAwr15WmwgyVENXo8/bg53ZteogGVxUJZw
JoeQ5HrWGUtLpHjurxWfON1Y1Av7W1IUDV1RnIfDngHCZZb4zQei4ELWnK1dhAED
RK0SuN69DA0egdjQLNr5MyNQhGtwJn3eW4IOEL8pGBoZZJtDGIgEF0zKg1/u0H6q
hOUzZlzXHrRp3IAohOtkPL2Dr/S29gVGZVPC3OQpftNLonGge9jpUYrS1Q7Yc1Wt
CEzXf1JXFeNPO/UXnLD0Z6tH5+mTV1YQHZFRps1RmJcIov5gy6ja7+Cjg+FLF/Fd
8WvR1QAwwDvTO1oIU8O1f3a3gZtOF0fnshcss4d0m/WlW+hx24sa6jr9/fQy7prQ
2vMhADHrP0YPTzaT/rpsPmS8u+XELdATLy+385rtC6e7Ck5ddCALBO8QuzqsfuFy
H9J9N+gJqmjZ60939V4Gkc1pMeda61r0O258tWb13jSG6Sqv2V9hjSwQu3fJRfr5
T36C+MN43uwaYjJ76tXrgpGy0mh0EVh/m0C+mHF/jy/WmG+yUSF52VZujHvaSFHe
5qADnA09N02qLw6BHt24Z/hP11u2eHRiIpVl3fBzs3VxXyP25/vq6OCfp6ZdAZ0v
UQxqlQDyFUzDroyrATfvSg7OEhqIc1j1o4R4NNRPJHpVWy3Nf1mKaM1eJ8S57N6C
FBzg662Ctak=
=vjqK
-----END PGP SIGNATURE-----

--=-wc9U1Ndo4DwKjqD3r9di--



--===============0766448476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0766448476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0766448476==--
