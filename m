From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: add support for multiple jack types
Date: Wed, 09 Feb 2011 21:54:21 +0000
Message-ID: <1297288461.3297.189.camel@odin>
References: <1297242857-18663-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A6C961039B4
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 22:54:25 +0100 (CET)
Received: by wwe15 with SMTP id 15so676845wwe.20
	for <alsa-devel@alsa-project.org>; Wed, 09 Feb 2011 13:54:25 -0800 (PST)
In-Reply-To: <1297242857-18663-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: Harsha Priya <priya.harsha@intel.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-02-09 at 14:44 +0530, Koul, Vinod wrote:
> From: Vinod Koul <vinod.koul@intel.com>
> 
> This patch adds soc-jack support for adding voltage zones and for
> detecting jack type
> 
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Harsha Priya <priya.harsha@intel.com>
> ---
>  include/sound/soc.h  |   23 +++++++++++++++++++++++
>  sound/soc/soc-jack.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 0 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
