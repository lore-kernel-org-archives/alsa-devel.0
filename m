From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 00/11] Remove set_cache_io entirely from
	ASoC probe
Date: Thu, 27 Mar 2014 13:34:28 +0000
Message-ID: <20140327133428.GL1665@opensource.wolfsonmicro.com>
References: <1395812433-26410-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3688F26536C
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 14:34:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1395812433-26410-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, shc_work@mail.ru, tiwai@suse.de, viresh.kumar@linaro.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, andrew.smirnov@gmail.com, broonie@kernel.org, akpm@linux-foundation.org, s.trumtrar@pengutronix.de, rf@opensource.wolfsonmicro.com, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 26, 2014 at 01:40:22PM +0800, Xiubo Li wrote:
>   ASoc: wm5102: Remove the set_cache_io() entirely from ASoC probe.
>   ASoc: wm5110: Remove the set_cache_io() entirely from ASoC probe.
>   ASoc: wm8350: Remove the set_cache_io() entirely from ASoC probe.
>   ASoc: wm8400: Remove the set_cache_io() entirely from ASoC probe.
>   ASoc: wm8994: Remove the set_cache_io() entirely from ASoC probe.
>   ASoc: wm8997: Remove the set_cache_io() entirely from ASoC probe.

For the above patches:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
