From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2] ASoC: Fix to avoid compile error
Date: Tue, 5 Apr 2011 08:23:18 +0900
Message-ID: <20110404232317.GC4609@opensource.wolfsonmicro.com>
References: <20110404045556.GA12690@opensource.wolfsonmicro.com>
	<1301892222-9152-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 344F51037E3
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Apr 2011 01:23:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1301892222-9152-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: alsa-devel@alsa-project.org, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 04, 2011 at 01:43:42PM +0900, Seungwhan Youn wrote:
> This patch fixes to avoid compile error when ASoC codec doesn't use I2C
> nor SPI on snd_soc_hw_bulk_write_raw().
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>

Applied, thanks.
