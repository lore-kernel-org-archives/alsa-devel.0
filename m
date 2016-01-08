From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8960: boost switch should be
 closed when using L/RINPUT1
Date: Fri, 8 Jan 2016 12:36:56 +0000
Message-ID: <20160108123656.GE1490@localhost.localdomain>
References: <3d52a0f560ed565ca81da1d041744e1814d7b561.1452243300.git.zidan.wang@freescale.com>
 <89e05efb7792deb496f216ed9e086e9c10053ba8.1452243310.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C475260421
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 13:37:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <89e05efb7792deb496f216ed9e086e9c10053ba8.1452243310.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 08, 2016 at 04:57:02PM +0800, Zidan Wang wrote:
> L/RINPUT1 can line to Left/Right Boost Mixer through boost switch.
> If boost switch is open, there will be no voice when using L/RINPUT1.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
