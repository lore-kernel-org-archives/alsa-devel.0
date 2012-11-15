From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v5 2/2] ASoC: mxs-saif: Remove platform data
Date: Thu, 15 Nov 2012 11:20:01 -0200
Message-ID: <CAOMZO5BBmSLB9boZYXuT4o_tywPx3f58p4yod+CuO=H1Pi-R2w@mail.gmail.com>
References: <1352924938-24789-1-git-send-email-festevam@gmail.com>
 <20121114231000.GB4536@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AA9A265B59
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 14:20:02 +0100 (CET)
Received: by mail-ob0-f179.google.com with SMTP id eq6so1467970obc.38
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 05:20:01 -0800 (PST)
In-Reply-To: <20121114231000.GB4536@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 14, 2012 at 9:10 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Nov 14, 2012 at 06:28:58PM -0200, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> All MXS users have been converted to device tree and the board files have been
>> removed.
>>
>> No need to keep platform data in the driver.
>
> I'm missing patch 1 here?

Sorry, I should not have marked it as 2/2. In my previous submissions
this was a patch series, but the now the other patches were already
applied into your tree.

Please consider it as only one patch instead.

Thanks,

Fabio Estevam
