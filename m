From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] gpio: arizona: Add wm8997 support to
	probe
Date: Mon, 17 Jun 2013 09:55:44 +0100
Message-ID: <20130617085544.GV1403@sirena.org.uk>
References: <1371054560-28770-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1371054560-28770-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <CACRpkdai-n92BzupB58HvWbDicVcAGLeW-vO4FPO5ezK8nnsJA@mail.gmail.com>
 <CACRpkdbQ10+g9yFDEWBRAy2oNnLYnpicLdYt5yD0q5hmi6S__A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1211522505710538257=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 977C72619D1
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2013 10:55:50 +0200 (CEST)
In-Reply-To: <CACRpkdbQ10+g9yFDEWBRAy2oNnLYnpicLdYt5yD0q5hmi6S__A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, tiwai@suse.de, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============1211522505710538257==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zf/1W2UEptUsgf2A"
Content-Disposition: inline


--zf/1W2UEptUsgf2A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2013 at 10:32:03AM +0200, Linus Walleij wrote:

> The definition of WM8997 is nowhere in the kernel tree,
> and I was not CC:ed on patches 1 & 2, can't even see them so
> I guess they were even sent to mailing lists I'm not on.

It's in patch 1 - all three patches will need to go in together.

--zf/1W2UEptUsgf2A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRvs8NAAoJELSic+t+oim97s8P/jkImkn+RTQI9zhBI7HmFK/y
ONTZr1drAQ9hGOfsT3CV4TV0QtgtKD9PrNRFNmg0K1OJLMal8To6GGFoLLWSmC1r
6vXGWSgDIez80BKj5bSkYfamm90mB5Iqp3XSQMRJmRweY5IYGTYTqCMl0xoHht33
axJt2id/eOsJcew4uvu1xeknRFWEeKxE2Pg9US5ICJVCIjbN/CJksAU5PhNjOTkr
DXpykOXVJsyMYn2418wVHwzInqqxDhvGRi0/iQJvW7YsO9KVp3N+F3NIOGodcqSV
uNgr1PIOlNfCKdzvSHwCnEmknDzuRlthBqeM+w+XVLhB5RnxITK2A+CTKOO1HS35
EAgUB/BdTrDA7clFiQCw9i3jLWv1DEywEQm5RcI7uk1mBr5NZ1F29dwM5xaPKHAJ
0NW7r//gxKcKELBDaVLYySRJdDPRPiFPjDeHRARyHG/+9sNdwxqNunqpW4fx3Swx
GiMmGEiWfnzAZX18sPbSZx5J7q6bPnXs9VO5UbgQBumlc3qlHRHooCQM7jSvfD1V
+cB5XbWOkln8eMrAq5U+Nm/9xYtyQr9lWdFEMZ4n18QBdzc4jE3uqyFBJdAPTwcy
pujR2N8cvKYH4pmBj/kI7GwNMvwYJxoN6u/0h7TiNFsMW+T2II4xtA6R0vXLngT1
kjjTOTtZ6LVlketPrTlB
=Cq1z
-----END PGP SIGNATURE-----

--zf/1W2UEptUsgf2A--

--===============1211522505710538257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1211522505710538257==--
