From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: wm5100: Export wm5100_detect
Date: Thu, 23 Jan 2014 11:46:58 +0000
Message-ID: <20140123114658.GC11589@opensource.wolfsonmicro.com>
References: <1390474406-5790-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DA7612619E4
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 12:46:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1390474406-5790-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 23, 2014 at 04:23:26PM +0530, Sachin Kamat wrote:
> Export the symbol so that it is accessible to modules. Fixes the
> following error:
> 
> ERROR: "wm5100_detect" [sound/soc/samsung/snd-soc-lowland.ko] undefined!
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
