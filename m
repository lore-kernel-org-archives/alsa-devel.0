From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RESENDING] [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP
 probe rather than as a device
Date: Fri, 23 Nov 2012 19:09:50 +0900
Message-ID: <20121123100949.GD4529@opensource.wolfsonmicro.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <20120919133343.GH25694@gmail.com>
 <505ADBE6.6080509@stericsson.com> <20120920125259.GA2755@gmail.com>
 <20121122140540.GA10986@gmail.com>
 <20121123015838.GH4385@opensource.wolfsonmicro.com>
 <20121123091236.GA17471@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8239277366277879225=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121123091236.GA17471@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, "arnd@arndb.de" <arnd@arndb.de>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============8239277366277879225==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 23, 2012 at 09:12:36AM +0000, Lee Jones wrote:
> On Fri, 23 Nov 2012, Mark Brown wrote:

> > Why do we need any ideas?  Just implement it already.

> How do you mean? I've written the patch, just accept it. ;)

Whatever the patch was I don't have it any more, you'll need to resend.

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQr0tlAAoJELSic+t+oim9qTwP/3hC4P9uzZ/qROp927C6Sj8L
GzssLR+MTqFX9dUEoYYW+C5iG8BOZ8ouU24HV6lJ9n7wygpyF3bKMVgKZMabVOT3
Cn0mFIOlbRCaTkfIkmKNI3RqPV+3E8nzsGX335/wJdnR+eR+Xr2Fb+EW9qPWDor9
rp5i7FCjPmmrc9eoaUHoHV40PsCtY0qj2FRPYJyBtBvPtInohj29JBJkn88r6Cc3
TkFIhYnE77uiYmzANZjX9DXnVAIQLe6wgqvY+2nvkc/99vzR0eOZCiiam3JHtIzo
VWuvvHsLR+sN6vE03HW72OwlkoRLMz+kqfomRQ0k4lDGDpF9o+I1YGEJ/TvuZpo1
/yLZ3GW9FcqgO19lgyNyKO1KqQtD8cs1pX49cZWdCSVxPGUKCFreWFPxrnCINw6n
mcZMBV2b5Bji8RGtY/2BwhU2JbX9sC5nws4VmtFemfbfGsmZMPmduplErkGqDyc1
Lwf3+5ubJmKcRmRBoeEkccd4wJFVgPIM1WWl0wzI0v1qppBWfLGbn2vZCyJjrXiI
9yIGfsgqZoa/zKEiqhX2gUHidUyoD4zMRb+EGKdg3L8xWbCN5BGC8/tT+wzOVPuP
VoL+NgYu+mRyeDCwk9QoouPTJGfg+/SFegwrbRzF64570S/Yq5NOFEoEqYBVDYi4
tXEXlX9WdyZk7LtM10XU
=Hw8I
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--


--===============8239277366277879225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8239277366277879225==--
