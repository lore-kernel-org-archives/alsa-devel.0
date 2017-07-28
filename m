From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 0/3] ASoC: Intel: Fixes in Kabylake
 machine driver for clear playback and recording
Date: Fri, 28 Jul 2017 08:51:57 +0530
Message-ID: <20170728032157.GU3053@localhost>
References: <1501202487-12617-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id A2FAC26763B
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 05:19:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1501202487-12617-1-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <harshapriya.n@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 27, 2017 at 05:41:24PM -0700, Harsha Priya wrote:
> This patch series includes fixes for clean playback and recording in kabylake machine driver.
> It fixes the below issues in the corresponding patches and the details of each fix
> is provided in the patch's commit message.
> 
> 1. Fix cracking noise in rt5663 headphones
> 
> 2. Fix pop noise of dmic recording 
> 
> 3. Enable 4 slot IV feedback for maxim amps

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
