From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: s3c6410/s3c64xx support in ALSA
Date: Wed, 8 Sep 2010 17:45:24 +0900
Message-ID: <AANLkTikQz1jL0ZPC1c0+PbzQCz259TK-_NQmFzeQm29z@mail.gmail.com>
References: <1283605929-15961-1-git-send-email-jslaby@suse.cz>
	<290463D19D2E064191F1F96ECA480A894323EC61F0@EXMAIL02.scwf.nsc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AB4724430
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Sep 2010 10:45:25 +0200 (CEST)
Received: by wwi18 with SMTP id 18so4402673wwi.20
	for <alsa-devel@alsa-project.org>; Wed, 08 Sep 2010 01:45:25 -0700 (PDT)
In-Reply-To: <290463D19D2E064191F1F96ECA480A894323EC61F0@EXMAIL02.scwf.nsc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Reddy, MR Swami" <MR.Swami.Reddy@nsc.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Sep 7, 2010 at 1:12 PM, Reddy, MR Swami <MR.Swami.Reddy@nsc.com> wrote:
> Hello,
> Could you plz let me know, if the S3C6410/S3C64XX supports in ALSA soc supported machines?

If my understand is right, smdk6410 board with wm8580(I2S) and
WM9713(AC97) is supported based on s3c6410 soc, and you can find
related codes in 'sound/soc/s3c24xx/*'.

>
> Thanks
> Swami
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

Thanks
Claude
