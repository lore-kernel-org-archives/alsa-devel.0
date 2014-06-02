From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: rsnd: fixup SSI interrupts style of
 DeviceTree
Date: Tue, 3 Jun 2014 08:52:07 +0900
Message-ID: <538D0E27.8030907@renesas.com>
References: <87sinrpofv.wl%kuninori.morimoto.gx@gmail.com>
 <20140530102358.GC6241@trinity.fluff.org>
 <87k393pmvv.wl%kuninori.morimoto.gx@renesas.com>
 <20140530105321.GD6241@trinity.fluff.org>
 <87fvjrpl1g.wl%kuninori.morimoto.gx@renesas.com>
 <538CEF11.8020803@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relmlie2.idc.renesas.com (relmlor3.renesas.com
 [210.160.252.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 87CD626556D
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 01:52:16 +0200 (CEST)
In-Reply-To: <538CEF11.8020803@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben.dooks@codethink.co.uk>, Ben Dooks <ben@trinity.fluff.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Ben

>> I thought that 1) current style was not good DT style
>> 2) there is a chance to exchange it because upstream
>> doesn't have user at this point.
>> Can you accept if it can keep compatibility ?
>
> I think the current method is the nicer, it keeps the descriptions
> each ssi as close as possible to the ssi. So, in answer to #1 I
> think it is the best.
>
> In answer to #2, it would be nicer not to unless you have a good
> reason to do this.

I re-considered about this patch.
And I can agree with your opinion.
I will skip this patch.
Thank you for your help
