From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/3] gpio: arizona: Add wm8997 support to
	probe
Date: Mon, 17 Jun 2013 10:57:16 +0200
Message-ID: <CACRpkdYktbqWmzTPi7bU6T_mYgdrPK-82tOZJLZNTi1WxTvGaQ@mail.gmail.com>
References: <1371054560-28770-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1371054560-28770-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <CACRpkdai-n92BzupB58HvWbDicVcAGLeW-vO4FPO5ezK8nnsJA@mail.gmail.com>
 <CACRpkdbQ10+g9yFDEWBRAy2oNnLYnpicLdYt5yD0q5hmi6S__A@mail.gmail.com>
 <20130617085544.GV1403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f54.google.com (mail-oa0-f54.google.com
 [209.85.219.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 06DCC261A3B
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2013 10:57:16 +0200 (CEST)
Received: by mail-oa0-f54.google.com with SMTP id o6so3079310oag.27
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2013 01:57:16 -0700 (PDT)
In-Reply-To: <20130617085544.GV1403@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, tiwai@suse.de, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 17, 2013 at 10:55 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jun 17, 2013 at 10:32:03AM +0200, Linus Walleij wrote:
>
>> The definition of WM8997 is nowhere in the kernel tree,
>> and I was not CC:ed on patches 1 & 2, can't even see them so
>> I guess they were even sent to mailing lists I'm not on.
>
> It's in patch 1 - all three patches will need to go in together.

OK I guess that's some MFD hub patch or something then,
Acked-by: Linus Walleij <linus.walleij@linaro.org> on this
patch FWIW.

Yours,
Linus Walleij
