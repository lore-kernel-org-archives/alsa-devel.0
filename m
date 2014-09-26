From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: ssm4567: Add driver for Analog
 Devices SSM4567 amplifier
Date: Fri, 26 Sep 2014 13:49:38 -0700
Message-ID: <CAOMFOmXG2hKH4c3yj8uYc_Eu31d05emYuXiv+zmc+Vqn2U8KhQ@mail.gmail.com>
References: <1411747721-38619-1-git-send-email-anatol.pomozov@gmail.com>
 <1411763466-29018-1-git-send-email-anatol.pomozov@gmail.com>
 <5425D0BC.4060405@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f170.google.com (mail-vc0-f170.google.com
 [209.85.220.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B6E32604EA
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 22:49:39 +0200 (CEST)
Received: by mail-vc0-f170.google.com with SMTP id ij19so7362838vcb.15
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 13:49:38 -0700 (PDT)
In-Reply-To: <5425D0BC.4060405@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi

On Fri, Sep 26, 2014 at 1:46 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 09/26/2014 10:31 PM, Anatol Pomozov wrote:
>>
>> Analog Devices SSM4567 is a boost class-D audio amplifier.
>>
>> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
>
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks!

Once your changes will be ready I'll be glad to test them. We do not
use output sensing yet but we might do it in the future.
