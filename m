From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix SPI driver binding for WM8987
Date: Wed, 10 Aug 2011 00:58:21 +0900
Message-ID: <20110809155820.GL15861@opensource.wolfsonmicro.com>
References: <1312362661-4544-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4E41253E.2040407@ti.com>
	<20110809150503.GE15861@opensource.wolfsonmicro.com>
	<4E415204.8020702@ti.com>
	<20110809153136.GH15861@opensource.wolfsonmicro.com>
	<4E415543.9040200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 950FB24606
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 17:58:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E415543.9040200@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 09, 2011 at 04:41:55PM +0100, Liam Girdwood wrote:

> Ah, ok - I would have just used WM8750 in subject instead.

It's specifically fixing wm8987, wm8750 was always fine but just happens
to be in the same driver.
