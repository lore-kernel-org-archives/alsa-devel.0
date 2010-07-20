From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: multi-component - Add Aquila
	sound driver
Date: Tue, 20 Jul 2010 10:03:04 +0100
Message-ID: <20100720090303.GK10222@rakim.wolfsonmicro.main>
References: <4C4533FC.8050407@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 05E051038A2
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 11:03:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C4533FC.8050407@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Seungwhan Youn <claude.youn@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 20, 2010 at 02:28:28PM +0900, Chanwoo Choi wrote:
> This patch add sound support for the Aquila board based on S5PC110.
> 
> The Aquila board is based on Samsung SoC(S5PC110) and include
> WM8994 codec over I2S to support sound. This uses the I2Sv4 driver
> compatible with I2Sv5 to run sound.

Once you've made the correction requested by Mr. Youn:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
