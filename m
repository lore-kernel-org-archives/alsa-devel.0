From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Tue, 11 Jun 2013 14:43:10 -0600
Message-ID: <51B78BDE.8010509@wwwdotorg.org>
References: <1370927416-12216-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id EBB562608BA
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2013 22:43:13 +0200 (CEST)
In-Reply-To: <1370927416-12216-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, lgirdwood@gmail.com, broonie@kernel.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 06/10/2013 11:10 PM, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
> 
> This patch adds the ALC5640 codec driver.
> 
> Signed-off-by: Bard Liao <bardliao@realtek.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

(Oh, I suppose those two lines above should really be swapped)

Tested-by: Stephen Warren <swarren@nvidia.com>

This time, both headphones /and/ speakers worked for me:-) I haven't
tested capture yet though.
