From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 047/102] ASoC: wl1273: Use
	SOC_ENUM_SINGLE_EXT_DECL()
Date: Sun, 23 Feb 2014 11:32:55 +0900
Message-ID: <20140223023255.GM25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-20-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2632970576336459660=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AB26264F8D
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:34:32 +0100 (CET)
In-Reply-To: <1392723517-12772-20-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2632970576336459660==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mzDsWmoYTs+XRn5Z"
Content-Disposition: inline


--mzDsWmoYTs+XRn5Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:03PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--mzDsWmoYTs+XRn5Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCV3UAAoJELSic+t+oim9kw0P/iPARwgzQ6eOUqzaFOuxdsDD
wO0Sgby40USJYU5WeXmpDP2gg+e9MqmwjI2GxSBqRwyMhwWgHNM12x5QDl2wDO6d
ROPJFP4/XfpJXGbfB1nxMAvyQy2wJhnMdIuKiHch3gst+wDg/YyYy47kQWyDz6s8
SYAb6PsCYyg/0oSf/OeBQe6T+rwVr7b8AODs8A1SjccYHMUvFUwtlkDzC+YJ4jL4
zPYP+3HNBtkjypstzPhSCQiSaRH9rPFdc9cQj7A3m1bV9h36Mv29AEyvU+UguE6+
LCXYmboEzckhmRUZJatSKJjCR8BJwPSTehRQFSfc6kxcXWCRjfXUnhK7+JdcTM+u
Z3DrY9Zo7QKFmhg7hdnnLKP6sLK/QaHyjdkSB7q+6VLhw7lWYPP96l4V7Burr4u7
VUAhTUmRkrL7ZYa1fh4nObd78UBj78xzjGeyJjtiIBQgiwOQ5UHth4L+XInz4O6H
ScHJg9LZXPyuZfxo5ccq7s1WAVwtdVRmttb5+g3JI/qc7EEpPXu/u1jfsRV+aiSf
ZlYAzs42XH/jzoUpjNvdjusDLmW+BNn6wbUjRtSnnva74BB0lAXbtc6eg5pGSMEt
FidL9EpJftOcvuyzi9fhzTLZA8dou1H7Zpgi47Q9t4sFO1pSY/AQKwwDogUI0GpG
Ow9sWR0gHUmbX11XHEY/
=C64Q
-----END PGP SIGNATURE-----

--mzDsWmoYTs+XRn5Z--

--===============2632970576336459660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2632970576336459660==--
