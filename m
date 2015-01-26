From: "a.renault@kaptalia.com" <a.renault@kaptalia.com>
Subject: Re: [alsa] Crackling after 6.45 hours
Date: Mon, 26 Jan 2015 16:06:38 +0100
Message-ID: <3689386.1altZZdO2m@linux-le0l.site>
References: <3427562.sVz54J9OhN@linux-le0l.site>
 <CAOMZO5CZjwdunjw=3uMGki782iAga5877_3huK41Axxi-cwqAg@mail.gmail.com>
 <54C654C0.9010307@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 63CDF2605D7
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 16:06:49 +0100 (CET)
In-Reply-To: <54C654C0.9010307@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Le lundi 26 janvier 2015 15:52:48 Lars-Peter Clausen a =E9crit :
> On 01/26/2015 03:44 PM, Fabio Estevam wrote:
> > On Mon, Jan 26, 2015 at 12:41 PM, a.renault@kaptalia.com
> > =

> > <a.renault@kaptalia.com> wrote:
> >> First of all, I had to comment the lspci part of the script because I =
am
> >> using busybox on my imx6. (Did not found a way to add it :S)
> >> =

> >> Then I have got this card :
> >> http://www.msc-technologies.eu/products/boards/qseven/msc-q7-imx6.html
> >> with a Wolfson WM9711.
> > =

> > Which kernel version are you using? Can you try 3.19-rc6 or at least
> > 3.18.3?
> This seems to be a vendor kernel based on 3.0 with custom audio drivers. =
As
> Clemens said this is most likely a driver bug. So I guess there is not th=
at
> much we can do.
> =

> - Lars
Ok thanks you all, =


I will try to take a look by myself then contacting the vendor, =


I will let you know.
-- =

Adrien
