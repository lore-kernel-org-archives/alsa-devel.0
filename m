From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/35] ASoC: wm8350: Convert to
	params_width()
Date: Thu, 31 Jul 2014 16:15:59 +0100
Message-ID: <20140731151559.GA617@opensource.wolfsonmicro.com>
References: <1406807898-5927-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3C93B2608D3
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 17:16:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1406807898-5927-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 31, 2014 at 12:57:44PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> The CODEC doesn't care how data is laid out in memory.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---

All looks good to me.

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
