From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix typo in snd_soc_dapm_put_volsw
Date: Fri, 28 Jan 2011 13:04:55 +0000
Message-ID: <1296219895.3335.54.camel@odin>
References: <1296165245-10828-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 015992456C
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 14:04:59 +0100 (CET)
Received: by wyi11 with SMTP id 11so3141782wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 05:04:59 -0800 (PST)
In-Reply-To: <1296165245-10828-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-01-27 at 14:54 -0700, Stephen Warren wrote:
> This fixes a regression introduced by:
> 97404f2e0386ac147cec00fc5d89ea475b04bd78
> ASoC: Do DAPM control updates in the middle of DAPM sequences
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
