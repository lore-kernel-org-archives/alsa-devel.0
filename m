From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: RX1950: Enable Mic Jack during glue
	driver init
Date: Mon, 10 Jan 2011 11:50:16 +0000
Message-ID: <20110110115015.GC23070@opensource.wolfsonmicro.com>
References: <1294344949-30670-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E674E103886
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 12:52:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294344949-30670-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 06, 2011 at 10:15:49PM +0200, Vasily Khoruzhick wrote:
> Enable Mic Jack during glue driver init, otherwise capture will not work.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Applied, thanks.
