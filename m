From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: mid-x86: Use the soc-jack apis for
 jack type detection
Date: Fri, 11 Feb 2011 00:02:21 +0000
Message-ID: <1297382541.3313.103.camel@odin>
References: <1297322881-20461-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E8262243FC
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 01:02:26 +0100 (CET)
Received: by wwe15 with SMTP id 15so1966204wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 16:02:26 -0800 (PST)
In-Reply-To: <1297322881-20461-1-git-send-email-vinod.koul@intel.com>
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

On Thu, 2011-02-10 at 12:58 +0530, Koul, Vinod wrote:
> From: Vinod Koul <vinod.koul@intel.com>
> 
> This patch modifies the mfld_machine to use the new jack apis for adding the
> voltage zones for jack type detection. It also modifed TI sn95031 codec driver
> to use these new apis
> 
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Harsha Priya <priya.harsha@intel.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
