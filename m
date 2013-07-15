From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/2] ARM: dts: imx51-babbage: Pass a real
 clock to the codec
Date: Mon, 15 Jul 2013 22:30:30 +0800
Message-ID: <20130715143028.GA23589@S2101-09.ap.freescale.net>
References: <1370826467-30399-1-git-send-email-festevam@gmail.com>
 <1370826467-30399-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 79CE9261616
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 16:30:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1370826467-30399-2-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lars@metafoo.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 09, 2013 at 10:07:47PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> On imx51_babbage the codec clock is activated via GPIO4_26.
> 
> Provide a real clock to the sgtl5000 codec via device tree.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
