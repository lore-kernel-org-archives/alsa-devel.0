From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 2/2] dmaengine: dw: Remove AVR32 bits
	from the driver
Date: Sun, 14 May 2017 18:34:57 +0530
Message-ID: <20170514130457.GK6263@localhost>
References: <20170509161837.48301-1-andriy.shevchenko@linux.intel.com>
 <20170509161837.48301-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ACCE2668AC
 for <alsa-devel@alsa-project.org>; Sun, 14 May 2017 15:02:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170509161837.48301-3-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 09, 2017 at 07:18:37PM +0300, Andy Shevchenko wrote:
> AVR32 is gone. Now it's time to clean up the driver by removing
> leftovers that was used by AVR32 related code.

Since the cover didn't mention any dependency, I went ahead and applied this
now

-- 
~Vinod
