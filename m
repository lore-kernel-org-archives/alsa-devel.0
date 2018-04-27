From: Garlic Tseng <garlic.tseng@mediatek.com>
Subject: Re: [PATCH] ASoC: mt6797: switch to SPDX license tag
Date: Fri, 27 Apr 2018 10:03:19 +0800
Message-ID: <1524794599.7389.3.camel@mtksdaap41>
References: <20180426025605.31874-1-kaichieh.chuang@mediatek.com>
 <7071d4e1-daf1-4847-1dbd-e5c77c709724@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 97EB2267860
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 04:03:27 +0200 (CEST)
In-Reply-To: <7071d4e1-daf1-4847-1dbd-e5c77c709724@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: alsa-devel@alsa-project.org, ryder.lee@mediatek.com, wsd_upstream@mediatek.com, chipeng.chang@mediatek.com, broonie@kernel.org, linux-mediatek@lists.infradead.org, KaiChieh Chuang <kaichieh.chuang@mediatek.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2018-04-26 at 12:46 +0200, Matthias Brugger wrote:
> I think you don't want to delete the first author but add you as a second one.
> I've seen this in other parts of the patch as well. Please check.
> 
> Regards,
> Matthias
> 
> >   */
> >  
> >  #include <linux/module.h>
> > diff --git a/sound/soc/mediatek/mt6797/mt6797-reg.h b/sound/soc/mediatek/mt6797/mt6797-reg.h
> > index 3330f73fc8bb..ffb55367f59f 100644
> > --- a/sound/soc/mediatek/mt6797/mt6797-reg.h
> > +++ b/sound/soc/mediatek/mt6797/mt6797-reg.h
> > @@ -1,17 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> >  /*
> >   * mt6797-reg.h  --  Mediatek 6797 audio driver reg definition
> >   *
> >   * Copyright (c) 2018 MediaTek Inc.
> > - * Author: Garlic Tseng <garlic.tseng@mediatek.com>
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 and
> > - * only version 2 as published by the Free Software Foundation.
> > - *
> > - * This program is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - * GNU General Public License for more details.
> > + * Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
> >   */
> >  
> >  #ifndef _MT6797_REG_H_
> > 

I don't involve in this code development.
I think treating me as an author is a mistake and fixing it is correct.

Thanks!

Garlic Tseng.
