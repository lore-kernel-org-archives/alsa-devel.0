From: Philippe =?ISO-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Subject: Re: Crash when probing imx_mc13783
Date: Thu, 26 Jul 2012 09:29:26 +0200
Message-ID: <3192997.N5KLupAYnr@laptop>
References: <CAOMZO5B4Z4jACQFt5gy2o3VLqGrQg+bXcN12ChysrQphYNxQBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.epfl.ch (smtp4.epfl.ch [128.178.224.218])
 by alsa0.perex.cz (Postfix) with SMTP id 10923264EEB
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 09:29:31 +0200 (CEST)
In-Reply-To: <CAOMZO5B4Z4jACQFt5gy2o3VLqGrQg+bXcN12ChysrQphYNxQBA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Le mercredi 25 juillet 2012 16:56:43 Fabio Estevam a =E9crit :
> Hi,
> =

> I have just tried 3.5.0-next-20120725+  on a mx31pdk board and I am getti=
ng:

> =

> Before I start to investigate this, I would like to know if there is
> some recent patch I am missing or any other suggestion.

Well, I'm able to boot 3.5 on my board (imx31 based), so it must be a patch =

between 3.5 and 3.5-next. It should be quite quickly bisectable.

Regards,

Philippe
