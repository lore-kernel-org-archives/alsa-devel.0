From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoc: tegra: Remove unneeded mach-type.h
	incldues
Date: Tue, 16 Jul 2013 10:55:43 -0600
Message-ID: <51E57B0F.40006@wwwdotorg.org>
References: <1373992223-27236-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 5175D265099
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 18:55:47 +0200 (CEST)
In-Reply-To: <1373992223-27236-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 07/16/2013 10:30 AM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>

Acked-by: Stephen Warren <swarren@nvidia.com>

I also tested that this doesn't cause any compile issues for
tegra_defconfig, so also take if you want:

Tested-by: Stephen Warren <swarren@nvidia.com>
