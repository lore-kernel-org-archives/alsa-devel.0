From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Atom: Configure media_loop1
 and sprot_loop in stereo
Date: Fri, 27 Jan 2017 11:16:29 +0530
Message-ID: <20170127054629.GA19244@localhost>
References: <20170126120704.5269-1-sebastien.guiriec@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 761A626790B
 for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2017 06:46:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170126120704.5269-1-sebastien.guiriec@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien Guiriec <sebastien.guiriec@intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, rakesh.a.ughreja@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 26, 2017 at 01:07:04PM +0100, Sebastien Guiriec wrote:
> Most of the devices are using stereo speakers so media_loop1 and
> sprot_loop default mode should be stereo.
> 
> As per default all the routing UCM configuration doesn't enable Post
> processing loops it is not impacting curent configurations.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
