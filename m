From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: rt5670: check if asrc is useable
Date: Fri, 14 Nov 2014 15:11:25 +0000
Message-ID: <20141114151125.GD3815@sirena.org.uk>
References: <1415793273-7844-1-git-send-email-bardliao@realtek.com>
 <1415793273-7844-2-git-send-email-bardliao@realtek.com>
 <5463B82E.7070303@metafoo.de>
 <ABFD875FF5FB574BA706497D987D48D701021F56@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8883314326995496527=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C2B75260534
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 16:12:53 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D701021F56@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "mengdong.lin@intel.com" <mengdong.lin@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "yao.jin@intel.com" <yao.jin@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============8883314326995496527==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKD3J7bvzdTQU03f"
Content-Disposition: inline


--QKD3J7bvzdTQU03f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 14, 2014 at 11:38:51AM +0000, Bard Liao wrote:

> Sure, I will resend the patch. Another question is that the patch is one
> of 4 patches series. Should I resend all of them?

No need to send patch 1 since I applied it but please resend the rest -
I assumed that patches 3 and 4 depended on patch 2.  In general resend
anything that hasn't been applied.

--QKD3J7bvzdTQU03f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUZhucAAoJECTWi3JdVIfQ+isIAIZ5Nh2YjnNSoCFq6TbUTTj0
Rf0ysNPooNajC8PaHIyYdFf3Nmtgux5tIKYptQ2c2sdrgfNUjCqL2UvMXY8r490X
aD0yXEGIDaWXkXrVPVmWtNK5jA/gkyJjtM+W0c2Pw0ZdQm1CL5qRiQACafRAdHI8
i4y0mvP2kv7eqQ2FeT7UiVb6aEZ8DkhnYxmO/8v0ZiemPPR/VwLhRPWT9kFRfESV
h8UVkgMjKz1bUiD5jW/+5Gm8qTSj6FinrhQVbMohnEgFwzDnLbhnL3Y3VUWblQhd
pMIcFYxZ6XdIUuYIJq1drP7+Hz5jFIJSQJMzzB1u1FoHyvxmyrYQleAu2AeCJJg=
=LmYF
-----END PGP SIGNATURE-----

--QKD3J7bvzdTQU03f--

--===============8883314326995496527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8883314326995496527==--
