From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 1/4] ALSA: compress: Replace complex if
 statement with switch
Date: Tue, 19 Apr 2016 11:51:32 +0530
Message-ID: <20160419062132.GH2274@localhost>
References: <1460457129-23281-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1460457129-23281-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C3942651DB
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 08:16:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1460457129-23281-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 12, 2016 at 11:32:06AM +0100, Charles Keepax wrote:
> A switch statement looks a bit cleaner than an if statement
> spread over 3 lines, as such update this to a switch.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
