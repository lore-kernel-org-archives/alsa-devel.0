From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC: DMA deferred probe dependencies
Date: Tue, 10 Dec 2013 18:01:29 +0000
Message-ID: <20131210180129.GF11468@sirena.org.uk>
References: <1386695920-1447-1-git-send-email-swarren@wwwdotorg.org>
 <20131210172939.GE11468@sirena.org.uk>
 <52A75030.2050503@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8767777069045176519=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 520CA2652AC
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 19:01:35 +0100 (CET)
In-Reply-To: <52A75030.2050503@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8767777069045176519==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
Content-Disposition: inline


--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2013 at 10:32:32AM -0700, Stephen Warren wrote:

> I'll resend the patch. You may have discarded it since you'd ack'd it
> for me to apply, but it's probably better if it goes into your tree
> first, and then I pull from you.

Ah, yes - that sounds familiar now that you mention it.  Either that or
I was expecting the whole series would get reposted at least once when
everyone had reviewed round 1.

--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSp1b2AAoJELSic+t+oim9u4wP/AkR+wIs+eCs6pykLzEN6aZO
CHjfRspBQM+ybLBFUrs6G/FssMdLDNt7bRM5FP1mrvveGthwSQgFQTDJ7P3Vwdgz
n0Qp4dTKcvaZlXU2h+4JfwBF/P7RyLl3Uga4Shrr6a6qDaiVe76RwOztghGKsih3
TKIDWzmBxXLKFFNrCylWESiQjKSq7bwJKQc4fjQBwqIk7k0jO3ptxPO5EvMzPwVL
9cCISj0S44RnWF5wZHX0yY4n1+SaTiAHgS8QouLROuLQe3t6gG0XcZQu61sxz9UR
lFzki5gAlqHILvX6AC3ppVvyek6f7mkgpkUGfvZvHMi8Jf1KxCwhZEF1fhDfzUmP
oAoR62hwYLIxajmkp5MX6u+f/zTSx4uotleF8Cp98jMCYxKHe/9Bo9eiBgeD67XB
emxj7yQv7KAAX/23999LH+DhHP92+MDtyePo5w1/y5De/u1wFai7QGUBaYKamucj
caAYSQcaYP8ny+VU7sKIx1/6jAhjvPjyRQ+ZGcRM8fABTkZnKAMLsk+K7VLbEWCD
gGpLEBK5B5CKUtd5eP0e4GYft9cYZtuT4gvivDlUqL7aHN2RVfhJ77LGtSYL2ndu
wcTiK2lxE89pEjqe5hK9jbKQfqPc/l8cnn6CamN69iSAirk3qTFagyLYJhB8yXbL
6+TVK+imqmO7Ypen/pzJ
=8TPt
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--

--===============8767777069045176519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8767777069045176519==--
