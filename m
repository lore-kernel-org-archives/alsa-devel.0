From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/1] ASoC: pcm3060: Add codec driver
Date: Tue, 28 Aug 2018 20:31:01 +0100
Message-ID: <20180828193101.GP2414@sirena.org.uk>
References: <20180821165246.9479-1-kmarinushkin@birdec.tech>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7099801400485824806=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 11DB326777B
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 21:31:20 +0200 (CEST)
In-Reply-To: <20180821165246.9479-1-kmarinushkin@birdec.tech>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, Kevin Cernekee <cernekee@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============7099801400485824806==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OoKXXPSaVc/Wpb6N"
Content-Disposition: inline


--OoKXXPSaVc/Wpb6N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2018 at 06:52:45PM +0200, Kirill Marinushkin wrote:
> Hello Mark,
>=20
> I am developing sound support for a Linux-based device, with playback and
> capture through the TI PCM3060 codec.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--OoKXXPSaVc/Wpb6N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluFovQACgkQJNaLcl1U
h9BjNwf/e9TwY5s3mEHxlDdtMsox6KLef85PAw7X2y3gffpMrlVVAd7QqnccmemK
JvHSYSStVjb5d5AYgv9L4dk/CVHl1F4j8aBmD8OhOizecWece7A9YRVJaPrmb2HN
ZB202BQDGYTMNKImx3y/yLUeXdb1bXsy+tDT8DnyXm47CqxtIPst9KlakX6xNX3J
urIpOCy52d/lpui5x8oDBxCEjwVozeg2MZFS76jSVshQbq5nhXqkjzf+GeCX6cUd
eJ5rqEhQDrbIAX2/B4SJrK5lnErCTNmX3pW1TDQtWKTVN5eBrDD+aZCsLH43/OkA
oHOvCgMt6+TFxu8pwj5sgGI8GBLYCQ==
=xsta
-----END PGP SIGNATURE-----

--OoKXXPSaVc/Wpb6N--

--===============7099801400485824806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7099801400485824806==--
