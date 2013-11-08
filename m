From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V0] ASoC: pxa-ssp: add TISSP mode support
Date: Fri, 8 Nov 2013 10:19:48 +0000
Message-ID: <20131108101948.GD2493@sirena.org.uk>
References: <1383640208-11919-1-git-send-email-zhouqiao@marvell.com>
 <20131106112421.GI11602@sirena.org.uk>
 <527C43D0.2030301@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6351820185850469238=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 58F34261705
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 11:20:00 +0100 (CET)
In-Reply-To: <527C43D0.2030301@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "trinity.qiao.zhou@gmail.com" <trinity.qiao.zhou@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org


--===============6351820185850469238==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iaYIJ+kOC8t17Zqq"
Content-Disposition: inline


--iaYIJ+kOC8t17Zqq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2013 at 09:52:16AM +0800, Qiao Zhou wrote:
> On 11/06/2013 07:24 PM, Mark Brown wrote:

> >What is TISSP mode in an audio context?

> It's normal SSP mode, and it has a pulse of one bit clock width,

OK, what is SSP mode?

--iaYIJ+kOC8t17Zqq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSfLq8AAoJELSic+t+oim9Y9QP/jsO4CpHhMEM1n9JNfrYVSjy
POQ32xuddQ+5+Rl85z4OtWf1bARt6FH0t2FYToGjEQaXRszQegzTiqiN4WCAXEVq
j3qL3YqukiYABtSc5LghZh81zel0b/fi5KbGiFG7NLm2F/l9CVVjfuoLTLOQM+1z
kbom8o4VDsDRUroiZg1yVF0ApLB5guwffMCZEza4JsajoawndAueBkzU/o4rfiq1
1exhEQmbI1UPMgl8rBokmrH4NdtZCKNPVOhfVLlI+Z0mct7vOtmXepjjsCAzDpFc
rJg8hTrntOKYErum1pUabvXn5/PQ40yaOIcz8IW6LyTG5oMR8vlXOa61a0ZDbzUX
5J23QXGMaeZTRhT2S0GjFfSQ13pJNDh+73G+8NKWYGPsyV7cAamgTEDV11bTPGnm
tjwMmKYgklL5zRvmyo2IpOekzh2ZPbRFkms/YI91oVNYn4xaXwVVyIPZwslE/DVW
FtKrpJDJaOcGm4mgK8y0hLSreOpMqk+4OIcL4iXP7qMYq1IJYBRXeOhYAGCj7Rw6
PQPTmMAn/7wnZb4o5NuEr/yqhCYtJwhpmp3aBuyI28v4crJFlu+ggIcQ3vu0J3pr
9FfljQd9mfD+YObQdXNFu5WEv5016K1AhMCJptYcit37Goh/5MWaX5Mg5hflhuo9
JkcJM7MFo0kXmhdKRk6V
=iU3q
-----END PGP SIGNATURE-----

--iaYIJ+kOC8t17Zqq--

--===============6351820185850469238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6351820185850469238==--
