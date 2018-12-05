From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH linux-next v3 7/7] clk: renesas: Add binding document for
 ADG
Date: Wed, 5 Dec 2018 09:04:00 +0000
Message-ID: <87tvjsbbgh.wl-kuninori.morimoto.gx@renesas.com>
References: <20181205074947.28151-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205074947.28151-1-jiada_wang@mentor.com>
Content-Language: en-US
Content-ID: <D8D42DA6DCBFCF47B978DD4AC916FAFD@jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "vladimir_zapolskiy@mentor.com" <vladimir_zapolskiy@mentor.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


Hi Jiada

> Add device tree bindings for Audio Clock Generator (ADG)
> of R-Car Socs.
>=20
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  .../clock/renesas,rcar-adg-clocks.txt         | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,rcar-=
adg-clocks.txt

We want to have this document on rsnd.txt instead of
not-exist-driver file

	/Documentation/devicetree/bindings/sound/renesas,rsnd.txt   =20

Best regards
---
Kuninori Morimoto
