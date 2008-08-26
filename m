From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Convert wm8731 to a new-style
	i2c	driver (testers wanted)
Date: Tue, 26 Aug 2008 20:08:11 +0100
Message-ID: <20080826190809.GC3461@sirena.org.uk>
References: <20080826182437.4c5e2f3e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CF9724133
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 21:08:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080826182437.4c5e2f3e@hyperion.delvare>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean Delvare <khali@linux-fr.org>
Cc: alsa-devel@alsa-project.org, Dmitry Baryshkov <dbaryshkov@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Eric Miao <eric.miao@marvell.com>, Andrew Victor <linux@maxim.org.za>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 26, 2008 at 06:24:37PM +0200, Jean Delvare wrote:
> Convert the wm8731 codec driver to the new (standard) device driver
> binding model.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

for the wm8731 driver - again, I can't test the machine drivers.
