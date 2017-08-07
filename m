From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pxa: don't select SSP for COMPILE_TESTing
Date: Mon, 7 Aug 2017 13:00:37 +0100
Message-ID: <20170807120037.la3kt4amtfiosn7b@sirena.org.uk>
References: <20170807104101.3540159-1-arnd@arndb.de>
 <20170807112030.zvz3flujilsixdj4@sirena.org.uk>
 <CAK8P3a3Zuu7HE4CphQR_wpbGvnupYRSdy3xFZu5UgsuvoOjnLQ@mail.gmail.com>
 <20170807114837.3bqsroayi3sipf4h@sirena.org.uk>
 <CAK8P3a0tjwxq+P+Ww+Rxjt9Z4+AsJMgvn3z0bHiPgO+4EWQHZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0824257529811429491=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK8P3a0tjwxq+P+Ww+Rxjt9Z4+AsJMgvn3z0bHiPgO+4EWQHZw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Jaroslav Kysela <perex@perex.cz>, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org


--===============0824257529811429491==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jtkazztcwqzryqtv"
Content-Disposition: inline


--jtkazztcwqzryqtv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 07, 2017 at 01:58:29PM +0200, Arnd Bergmann wrote:
> On Mon, Aug 7, 2017 at 1:48 PM, Mark Brown <broonie@kernel.org> wrote:

> > Still missing a few steps of reasoning here...

> Sorry, I just realized that you were trying to point out the incomplete
> changelog. I must have accidentally closed the editor while working on
> it, and then sent it out today after getting no regressions.

> I'll resend with a proper changelog.

Thanks!

--jtkazztcwqzryqtv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmIVmQACgkQJNaLcl1U
h9B3Lwf/fGvg2aUL3DANavmx7bPEWNHmvzgq6oIESpDOgYOkO5q6bUNg3nJmoemu
hemQSdYuPJUIvawgKzjo7nkHXoVEJ27t0xNhq5i3bZb/ZzQYIwPE2vF1vKlGwemA
XO/cG1+WCI2Y8/d3NrTOKkmZ5tW+U3LAiq02xuljw2YSdJ0WlyLem1hVB8pvvKxI
zhFMheu7+dLkQdkER6R/TRbDKkoapDX+TvNvgcRAP8M0K2s8NMXEWFQAjVIxmuBt
jms3Oei16zU+x7mq8bo1HbmFy+r+n68wND9OuU8uMjnR2fOliJ4GanhubIi6AD1x
GHOp52krWlvYyw5VuZ0yEr58+fXDiw==
=fCyR
-----END PGP SIGNATURE-----

--jtkazztcwqzryqtv--


--===============0824257529811429491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0824257529811429491==--
