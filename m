From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v1] soundwire: mipi_disco: Switch to use
 fwnode_property_count_uXX()
Date: Fri, 2 Aug 2019 17:15:46 +0530
Message-ID: <20190802114546.GF12733@vkoul-mobl.Dlink>
References: <20190723194218.69168-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4686AF80214
 for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2019 22:06:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190723194218.69168-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 23-07-19, 22:42, Andy Shevchenko wrote:
> Use use fwnode_property_count_uXX() directly, that makes code neater.

Applied, thanks

-- 
~Vinod
