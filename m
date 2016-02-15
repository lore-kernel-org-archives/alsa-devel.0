From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 0/4] Add support for DAI link addition
 dynamically
Date: Mon, 15 Feb 2016 15:22:07 +0100
Message-ID: <56C1DF0F.4080503@metafoo.de>
References: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-008.synserver.de (smtp-out-072.synserver.de
 [212.40.185.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 81F69260664
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 16:11:44 +0100 (CET)
In-Reply-To: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>, alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, mengdong.lin@linux.intel.com, peter.ujfalusi@ti.com
List-Id: alsa-devel@alsa-project.org

On 02/15/2016 01:19 PM, Vaibhav Agarwal wrote:
> Following patches are based on for-next branch from broonie tree.
> First 2 patches include changes in existing soc, core framework
> to prepare for adding support for dynamic DAI link addition/
> removal
> 
> Patch 3 & 4 contains actual changes to enable dynamic DAI link
> support
> 
> NOTE:
> Currently, the code is tested on Pandaboad ES revB3 for playback
> usecase.

Can you outline how exactly that would work?

Thanks,
- Lars
