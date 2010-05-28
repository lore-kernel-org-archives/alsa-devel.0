From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH] alsa/Au1xxx-PSC: use resource_size
Date: Fri, 28 May 2010 07:08:22 +0200
Message-ID: <AANLkTil1hKb8QdsKEfHseOyPdw8uIY6d5mVEUwZ68T-p@mail.gmail.com>
References: <4BFF33B3.1040506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 40ECB1037EA
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 07:08:25 +0200 (CEST)
Received: by iwn35 with SMTP id 35so37491iwn.38
	for <alsa-devel@alsa-project.org>; Thu, 27 May 2010 22:08:22 -0700 (PDT)
In-Reply-To: <4BFF33B3.1040506@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: manuel.lauss@gmail.com, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

2010/5/28 Wan ZongShun <mcuos.com@gmail.com>:
> Dear Manuel & Mark,
>
> I make a little modification to use the 'resource_size'.

It's okay with me.  You could also modifiy psc-ac97.c in the same way.

       Manuel Lauss
