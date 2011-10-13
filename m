From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 5/9] ASoC: da7210: Add support for other
 DAI word lengths, format and mode
Date: Thu, 13 Oct 2011 17:37:14 +0100
Message-ID: <20111013163713.GM5193@opensource.wolfsonmicro.com>
References: <1318515243.12107.486.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 637BF10382A
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 18:37:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318515243.12107.486.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 13, 2011 at 07:44:03PM +0530, Ashish Chavan wrote:
> This patchs adds support for following,
> (1) DAI 20 and 32 bit word sizes
> (2) DAI left and right justified formats
> (3) DAI slave mode

Always generate patches against the current development version of the
tree you're submitting against.  I can tell you're not doing that
because I applied this patch yesterday...
