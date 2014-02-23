From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 061/102] ASoC: wm_hubs: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:44:59 +0900
Message-ID: <20140223024459.GB25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-34-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6598125641097787062=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 31E24264FF9
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:45:11 +0100 (CET)
In-Reply-To: <1392723517-12772-34-git-send-email-tiwai@suse.de>
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


--===============6598125641097787062==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f8UppZzm5eRNGSBg"
Content-Disposition: inline


--f8UppZzm5eRNGSBg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:17PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--f8UppZzm5eRNGSBg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWCoAAoJELSic+t+oim9OTcP/jlPD7iIC7z96JomNWXnpll8
TWOQ8zXNTs0tVlh2v5esG9rdAVwdXZ0kzHGnsY6RRg6eHd7swflqyPgapqE+5pMu
lautBzQNeZdIt2lAxh+P8eqWSSyMzFm9geGqfplFLbBJNIuz6biTPP4BFnnjGgWT
qA5n5Idi0lDnBwh20C3oaoscXjscyeefQ0yn9j7bFb/ll757RZPawUyhkL167J/B
eVd1GTScndrkqsv6kz65yyHsI26VSUmxw3S2Hd4kyNkGFdAoRJ/f7tYggW1cw8yZ
hKoy9FSmCDQdmBdj5ZMJJpL4xDLdVeEx9pyoj8oOSE0U1B8THZgPws8OcpWtf3Lr
1nb6pz+jzs3GejjaIJvRjfUWtmROR/HqWbwDbfaZ7YcJHsS8hAjVYTweZB9v1q7l
E1VXmCNYiUFcjJR6vml02uDOfT2xRFdGRBK0wNAXNYuhju883ZiE3AQB0stimWDE
VG0WuDhzHkywgj2DvQaTg4keqHYc6CMiS8CCzl23qhOPFuCLaZDoZX0cxjENITR1
EWUJzyDef+AhFbyV/zXryiTrsaYaoCagnfm94d/jvVyy7Od/Iq9NFk5WIIhj8O9A
C+EanJA+9WfZpBSCrA06GmAjaMrqF24oWsd7jpp/ZCdsPp8Vc9ZbIOqsyjy1MGxX
yfHmfB8qrNc/Q1E2WxRg
=l9Tl
-----END PGP SIGNATURE-----

--f8UppZzm5eRNGSBg--

--===============6598125641097787062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6598125641097787062==--
