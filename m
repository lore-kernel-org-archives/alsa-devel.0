From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH -next] soundwire: Fix typo in return value check of
 sdw_read()
Date: Wed, 3 Jan 2018 08:54:39 +0530
Message-ID: <20180103032439.GC18649@localhost>
References: <1514866099-108711-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1514866099-108711-1-git-send-email-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 02, 2018 at 04:08:19AM +0000, Wei Yongjun wrote:
> Fix the typo, 'status' should be instead of 'status2'.
> 
> Fixes: b0a9c37b0178 ("soundwire: Add slave status handling")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied, thanks

-- 
~Vinod
