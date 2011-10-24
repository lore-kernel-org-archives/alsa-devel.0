From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8996: Avoid a redundant
 i2c_get_clientdata call in wm8996_i2c_remove
Date: Mon, 24 Oct 2011 14:08:58 +0200
Message-ID: <20111024120857.GF6148@opensource.wolfsonmicro.com>
References: <1319427072.5773.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0F84210382A
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Oct 2011 14:09:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1319427072.5773.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 24, 2011 at 11:31:12AM +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks.
