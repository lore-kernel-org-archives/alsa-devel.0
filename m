From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Still have problems/issues using SGTL5000 with
 i.MX28 CPU
Date: Fri, 29 May 2015 10:50:40 -0300
Message-ID: <CAOMZO5DQg6=nbvn31eMMraLdzGN+jG6kgufy2N7KRCW36dxidQ@mail.gmail.com>
References: <55681B8B.6010700@eurekelettronica.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com
 [209.85.215.42])
 by alsa0.perex.cz (Postfix) with ESMTP id F237C26068A
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 15:50:43 +0200 (CEST)
Received: by lagv1 with SMTP id v1so56205609lag.3
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 06:50:41 -0700 (PDT)
In-Reply-To: <55681B8B.6010700@eurekelettronica.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gianluca <gianlucarenzi@eurekelettronica.it>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Peter Chen <peter.chen@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 29, 2015 at 4:55 AM, gianluca
<gianlucarenzi@eurekelettronica.it> wrote:
> Hello everybody!
>
> I put all those people on Cc: because of I think every guy can be able to
> handle the issue for its side easly.
>
> I started a discussion in FreeScale Community website:
>
> https://community.freescale.com/thread/356362
>
> Basically I designed 4 boards using the IMX28EVK board as reference.
> Usually the audio section was a buzzer (pwm), or simply using a SGTL5000 as
> playback only.
>
> Now we need to record some sounds as soon as the SGTL5000 has the SAIF1 line
> used for caputure (line in / mic in).

Does recording work on mx28evk with 4.0.4?

Regards,

Fabio Estevam
