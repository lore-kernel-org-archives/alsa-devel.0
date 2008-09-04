From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/9] ASoC: Blackfin: SPORT peripheral
	interface driver
Date: Thu, 4 Sep 2008 11:47:53 +0100
Message-ID: <20080904104753.GC12775@rakim.wolfsonmicro.main>
References: <1220516528-20301-1-git-send-email-cooloney@kernel.org>
	<1220516528-20301-4-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 14F5E24159
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 12:47:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1220516528-20301-4-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>
Cc: Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 04, 2008 at 04:22:02PM +0800, Bryan Wu wrote:
> From: Cliff Cai <cliff.cai@analog.com>

> SPORT is a serial port which can support serveral serial communication protocols.
> It can be used as I2C/PCM/AC97. For further information, please look up the HRM.

> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

with the proviso that there's no ALSA or ASoC interfacing stuff in here
so I'm likely to miss stuff.
