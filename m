From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
Date: Mon, 27 Feb 2017 08:44:58 +1100
Message-ID: <bb7f470f-ab3c-4185-ac4b-431bc8b9c000@flatmax.org>
References: <cover.1487997974.git.flatmax@flatmax.org>
 <20170225133952.GA28091@camel2.lan>
 <8cf68a3e-330d-e76d-e276-5df5453e3baf@flatmax.org>
 <20170226144958.GA5543@camel2.lan>
 <141ed0ce-2801-1ace-84b5-c2881ad8921d@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nschwmtas03p.mx.bigpond.com (nschwmtas03p.mx.bigpond.com
 [61.9.189.143]) by alsa0.perex.cz (Postfix) with ESMTP id C719F266A74
 for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2017 22:45:02 +0100 (CET)
In-Reply-To: <141ed0ce-2801-1ace-84b5-c2881ad8921d@laposte.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: emmanuel.fuste@laposte.net
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org



On 27/02/17 07:41, Emmanuel Fust=E9 wrote:
>
>
> I'm a complete newbie to ASoC  but I take part to this tread to learn =

> as I hate to see how badly all diy and amateur audio hw are integrated =

> with Alsa/ASoC/Linux and so never go upstream. On a =

> professional/commercial dev, you would never take this ... convoluted =

> I2S multi channel path.
>

Hey Emmanuel,

We now know that we can retrofit legacy I2S silicon for multichannel, in =

a very direct manner.

If you were a chip manufacturer and you could potentially increase your =

market take up by hundreds of millions of new potential low power =

devices, wouldn't you manufacture ALL new chips with these minor =

modifications ?

Matt
