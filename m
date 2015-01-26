From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa] Crackling after 6.45 hours
Date: Mon, 26 Jan 2015 12:44:55 -0200
Message-ID: <CAOMZO5CZjwdunjw=3uMGki782iAga5877_3huK41Axxi-cwqAg@mail.gmail.com>
References: <3427562.sVz54J9OhN@linux-le0l.site> <54C62E62.3060904@metafoo.de>
 <39512580.o0cGg5VYGZ@linux-le0l.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f175.google.com (mail-lb0-f175.google.com
 [209.85.217.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A4642605D7
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 15:44:56 +0100 (CET)
Received: by mail-lb0-f175.google.com with SMTP id 10so7887377lbg.6
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 06:44:56 -0800 (PST)
In-Reply-To: <39512580.o0cGg5VYGZ@linux-le0l.site>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "a.renault@kaptalia.com" <a.renault@kaptalia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 26, 2015 at 12:41 PM, a.renault@kaptalia.com
<a.renault@kaptalia.com> wrote:

> First of all, I had to comment the lspci part of the script because I am using
> busybox on my imx6. (Did not found a way to add it :S)
>
> Then I have got this card : http://www.msc-technologies.eu/products/boards/qseven/msc-q7-imx6.html
> with a Wolfson WM9711.

Which kernel version are you using? Can you try 3.19-rc6 or at least 3.18.3?
