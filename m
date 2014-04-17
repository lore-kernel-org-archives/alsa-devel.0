From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] sound: lx_core: Few misc cleanups
Date: Thu, 17 Apr 2014 11:52:21 +0200
Message-ID: <20140417095221.GC4132@lukather>
References: <1396966533-505-1-git-send-email-maxime.ripard@free-electrons.com>
 <s5hd2grq6d9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8639109640576356489=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id DE0C1265196
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 11:55:12 +0200 (CEST)
In-Reply-To: <s5hd2grq6d9.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8639109640576356489==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Content-Disposition: inline


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 09, 2014 at 10:01:06AM +0200, Takashi Iwai wrote:
> At Tue,  8 Apr 2014 16:15:33 +0200,
> Maxime Ripard wrote:
> >=20
> > This file had a few comments in french that are now in english, and too=
k the
> > opportunity to cleanup a bunch of #if 0 .. #endif and commented out code
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>=20
> The patch isn't applicable any longer.  Could you rebase to either
> Linus git tree or sound git tree for-linus branch, and resubmit?

I just did, and fixed a few stuff that have been introduced along the way.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTT6RVAAoJEBx+YmzsjxAgTlEP/3tv3EtJnTMSUzg5KqwTcHGU
fwpTLkdDT3pHR7gOj2a5VUTfOhFEwbUN8D2DiUXAHzWSjTQy9ggYIe9PpwdwtKlf
rjj5XTeQlVU7HJZyruAVOXjTpTNrbwv2iwBYA1uLD+lG0hs+k+Q8w/X2xHqSQVXv
7IKybcXDbg7tHVD/VmwNaJjQfbc9D3/bhvFe1B4NFCswb3hTIVhxjk5jLxoVhINA
OKvqmqizOEqhNNwfGavHu0UirZGlk8ZhHQKMioTRF/BHj0dt+Ko9qXhrXn9kNu83
sN3c1f9U82eGMjLgOmPb2gw94Axjm92vC0YU3DNKhGsK249higSHcXFJAzbiq7AI
Rq5nKPLRni3pMc6ouvyCpp+gWyaBiJD1WkguZ754EAxDLH9HSZpqrUAjC5xcmdn9
ASm4NLbQDCV5uAR5FVlQL6jbiNV2bEAsoFTjL+zLO/e4Q6cZsoNkjXGGZjSD4iL5
wnCk8CmsxcZcEApIjnLl9Wr1kCU8xUJfR3YxkaeeNZUeoCQheOO59L437rDlLYfY
N77B9wcVy/+q71SgElhSYIvNT1I7RXeAA5zcloeWJD3YW17blgflXBDD4MBkgXqS
9h800hI5KXPPIfJZVCzai6jrkpyUrTFAHAAFf8o+CwlWlwuJCOL0iPGjrianimFi
M40irYpCINjmyFo735ba
=oxjq
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--

--===============8639109640576356489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8639109640576356489==--
