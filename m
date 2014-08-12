From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3 v4 RESEND] ASoC: arizona: Add DVFS
	handling for	sample rate control
Date: Tue, 12 Aug 2014 14:34:58 +0100
Message-ID: <20140812133458.GD15833@opensource.wolfsonmicro.com>
References: <20140808133233.GA2665@opensource.wolfsonmicro.com>
 <20140808133510.GC2665@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CF4D52651B8
 for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2014 15:34:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140808133510.GC2665@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, rf@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 08, 2014 at 02:35:10PM +0100, Richard Fitzgerald wrote:
> From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> 
> Some codecs need to boost DVFS for higher sample rates.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---

Hi Mark,

Would it be possible to get an Ack for the ASoC patches here, Lee
said it would be ok to put the series through the MFD tree once
we have an ack? Unless you have any issues with the series?

Thanks,
Charles
