From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Error with "Unsigned 8 bit, Rate 8000 Hz,
	Mono" track
Date: Fri, 10 Aug 2012 10:04:12 -0300
Message-ID: <CAOMZO5C7SFzdqeV9x5W2fQem3qYprXUc_MNizr1HRwJ4zKBsSA@mail.gmail.com>
References: <CAOMZO5Dc38HSZRXFeZ-55KN83v1NNPCAAuoiFdixJ0K2dw90vg@mail.gmail.com>
 <20120810110004.GA7142@shlinux2.ap.freescale.net>
 <CAOMZO5CdyZ8ONK+iOK-UVnL-K02gCP7-w6Aoj+cL-1g=K0B0rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E2B826655F
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 14:34:27 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so2086466obb.38
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 06:04:12 -0700 (PDT)
In-Reply-To: <CAOMZO5CdyZ8ONK+iOK-UVnL-K02gCP7-w6Aoj+cL-1g=K0B0rQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Lauri Hintsala <lauri.hintsala@bluegiga.com>
List-Id: alsa-devel@alsa-project.org

On 8/10/12, Fabio Estevam <festevam@gmail.com> wrote:

> I can play this file on a mx51evk and mx6qsabrelite boards, which also
> uses a sgtl5000.

Ok, these boards have sgtl5000 in master mode.

Only on mx28evk we have sgtl5000 in slave mode.
