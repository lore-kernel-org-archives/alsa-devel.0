From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: wm8962: remove 64k sample rate
 support
Date: Fri, 18 Sep 2015 13:50:12 +0100
Message-ID: <20150918125012.GJ7694@ck-lbox>
References: <4c1fe5d2fa0ae6cf85e9be8b3b8a52feaae7d75b.1442566367.git.zidan.wang@freescale.com>
 <2e8075642e5d428b1136b3b7b18be5b7d30c358a.1442566367.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id A90E2260435
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 15:13:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2e8075642e5d428b1136b3b7b18be5b7d30c358a.1442566367.git.zidan.wang@freescale.com>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 18, 2015 at 05:19:25PM +0800, Zidan Wang wrote:
> wm8962 can't support 64k sample rate. When playing a 64KHz wave file,
> 'Unsupported rate 64000Hz' will be prompted.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
