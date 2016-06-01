From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 0/3] ASoC: Reduce audio related kernel
	spew.
Date: Wed, 1 Jun 2016 11:26:59 +0530
Message-ID: <20160601055658.GR16910@localhost>
References: <1461711790-7277-4-git-send-email-vedang.patel@intel.com>
 <1464743701-14931-1-git-send-email-vedang.patel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 391A526523B
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 07:50:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1464743701-14931-1-git-send-email-vedang.patel@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vedang.patel@intel.com
Cc: jeeja.kp@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, marc.herbert@intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 31, 2016 at 06:14:58PM -0700, vedang.patel@intel.com wrote:
> From: Vedang Patel <vedang.patel@intel.com>
> 
> There have been complaints regarding audio related kernel messages flooding
> dmesg. This series tries to address those complaints.
> 
> Also, I have created 3 different patches for this because they touch different
> drivers. But, I can combine those to reduce the number of patches.
Split sound fine to me

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
